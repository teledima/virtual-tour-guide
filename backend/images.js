const passport = require('passport')
const mime = require('mime-types')
const express = require('express')
const router = express.Router()

const minioClient = require('./utils/minio')

router.use(passport.authenticate('jwt', { session: false }))

router.get('/:image', (req, res) => {
    minioClient.getObject('demo-images', req.params.image, function(err, stream) {
        if (err) {
            return console.log(err)
        }
        let data = []
        stream.on('data', (chunk) => data.push(chunk))
        stream.on('end', () => {
            res.status(200).type(mime.contentType(req.params.image)).send(Buffer.concat(data));
        })
        stream.on('error', (err) => console.log(err))
    })
})

module.exports = router
