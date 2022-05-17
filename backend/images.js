const express = require('express')
const router = express.Router()

const minio = require('minio')
const mime = require('mime-types')

const multer = require('multer')
const storage = multer.memoryStorage()
const uploadMemory = multer({storage: storage})

const createThumbnail = require('./utils/thumbnail');

let client = new minio.Client({
    endPoint: 'localhost',
    port: 9000,
    useSSL: false,
    accessKey: 'minio',
    secretKey: 'minio-admin'
})

router.get('/:image', (req, res) => {
    client.getObject('demo-images', req.params.image, function(err, stream) {
        if (err)
            return console.log(err)

        let data = []
        stream.on('data', (chunk) => data.push(chunk))
        stream.on('end', () => {
            client.getObjectTagging('demo-images', req.params.image, (err, tags) => {
                const content_type = tags.find((item) => item.Key === 'content-type').Value
                res.status(200).type(content_type).send(Buffer.concat(data))
            })
        })
        stream.on('error', (err) => console.log(err))
    })
})

router.post('/', uploadMemory.single('image'),(req, res) => {
    client.putObject(
        'demo-images', 
        req.file.originalname+`.${mime.extension(req.file.mimetype)}`, 
        req.file.buffer, 
        req.file.size,
        { 'content-type': req.file.mimetype },
        async (err, putRes) => {
            if (err) {
                res.status(500).send(err.message)
            } else {
                try {
                    const thumbnail = await createThumbnail(req.file.buffer);
                    client.putObject(
                        'demo-images', 
                        req.file.originalname+`_thumbnail.${mime.extension(req.file.mimetype)}`, 
                        thumbnail,
                        { 'content-type': req.file.mimetype }
                    )
                    res.status(200).send();
                } catch(e) {
                    res.status(500).send(e.message)
                }
            }
        },
    );
})

module.exports = router
