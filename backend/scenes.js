const passport = require('passport')
const { ObjectId } = require('mongodb')
const multer = require('multer')
const mime = require('mime-types')
const express = require('express')
const router = express.Router()

const storage = multer.memoryStorage()
const uploadMemory = multer({storage: storage})

const { getThumbnail, minioClient, mongo } = require('./utils')
let { mongoClient, tourCollection } = mongo

router.use(passport.authenticate('jwt', { session:false }))

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
        const thumbnail = await getThumbnail(req.file.buffer);
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

module.exports = router;
