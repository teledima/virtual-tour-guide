const express = require('express')
const router = express.Router()

const minio = require('minio')
const { ObjectId } = require('mongodb')
const mime = require('mime-types')

const multer = require('multer')
const storage = multer.memoryStorage()
const uploadMemory = multer({storage: storage})

const createThumbnail = require('./utils/thumbnail');
let { mongoClient, db_name } = require('./utils/mongo');

let minioClient = new minio.Client({
    endPoint: 'localhost',
    port: 9000,
    useSSL: false,
    accessKey: 'minio',
    secretKey: 'minio-admin'
})

const tourCollection = mongoClient.db(db_name).collection('tours')

router.get('/:image', (req, res) => {
    minioClient.getObject('demo-images', req.params.image, function(err, stream) {
        if (err)
            return console.log(err)

        let data = []
        stream.on('data', (chunk) => data.push(chunk))
        stream.on('end', () => {
            res.status(200).type(mime.contentType(req.params.image)).send(Buffer.concat(data));
        })
        stream.on('error', (err) => console.log(err))
    })
})

router.post('/', uploadMemory.single('image'), async(req, res) => {
    const imageName = new ObjectId().toHexString();
    const imageNameExt = imageName+`.${mime.extension(req.file.mimetype)}`;
    const thumbnailNameExt = imageName+`_thumbnail.${mime.extension(req.file.mimetype)}`;

    try {
        const uploadPanoRes = await minioClient.putObject(
            'demo-images', 
            imageNameExt, 
            req.file.buffer, 
            req.file.size,
            { 'content-type': req.file.mimetype }
        );

        mongoClient = await mongoClient.connect();
    } catch(e) {
        res.status(500).send(e.message);
        return;
    }


    const sceneId = new ObjectId();
    let thumbnailPutRes = null;
    let thumbnailErr = null 

    try {
        const thumbnail = await createThumbnail(req.file.buffer);
        thumbnailPutRes = await minioClient.putObject(
            'demo-images', 
            thumbnailNameExt, 
            thumbnail,
            { 'content-type': req.file.mimetype },
        )
    } catch(e) {
        thumbnailErr = e
    };

    try {
        const updateRes = await tourCollection.updateOne(
            { _id: new ObjectId(req.body['tourId']) },
            { $push: { 
                scenes: { 
                    sceneId: sceneId, 
                    title: req.file.originalname, 
                    panorama: imageNameExt,
                    thumbnail: thumbnailPutRes !== null ? thumbnailNameExt : null,
                    hotSpots: []
                } } 
            }
        )
        res.status(200).send(updateRes)
    } catch(e) {
        res.status(500).send(e.message);
    } finally {
        mongoClient.close();
    }
    
})

module.exports = router
