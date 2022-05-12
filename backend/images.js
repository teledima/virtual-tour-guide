const express = require('express')
const minio = require('minio')
const router = express.Router()

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
            let content_type = null
            client.getObjectTagging('demo-images', req.params.image, (err, tags) => {
                content_type = tags.find((item) => item.Key === 'content-type').Value
                res.status(200).type(content_type).send(Buffer.concat(data))
            })
        })
        stream.on('error', (err) => console.log(err))
    })
})

module.exports = router
