const passport = require('passport')
const multer = require('multer')
const mime = require('mime-types')
const express = require('express')

const storage = multer.memoryStorage()
const uploadMemory = multer({storage: storage})

const { getThumbnail, getRandomString, minioClient, logger } = require('../utils')
const { Tour } = require('../models')

const router = express.Router()
router.use(passport.authenticate('jwt', { session:false }))

router.post('/', uploadMemory.single('image'), async(req, res) => {
    const imageName = getRandomString(15);
    const imageNameExt = imageName+`.${mime.extension(req.file.mimetype)}`;
    const thumbnailNameExt = imageName+`_thumbnail.${mime.extension(req.file.mimetype)}`;

    try {
        await minioClient.putObject(
            'demo-images', 
            imageNameExt, 
            req.file.buffer, 
            req.file.size,
            { 'content-type': req.file.mimetype }
        );
    } catch(e) {
        logger.error(e)
        res.status(500).send(e.message);
        return;
    }

    let thumbnailPutRes = null;
    try {
        const thumbnail = await getThumbnail(req.file.buffer);
        thumbnailPutRes = await minioClient.putObject(
            'demo-images', 
            thumbnailNameExt, 
            thumbnail,
            { 'content-type': req.file.mimetype },
        )
    } catch(e) {
        logger.error(e)
    };

    try {
        let tour = await Tour.findById(req.body.tourId)
        tour.scenes.push({ 
            title: req.file.originalname, 
            panorama: imageNameExt, 
            thumbnail: thumbnailPutRes !== null ? thumbnailNameExt : null,
        })
        tour = await tour.save()
        res.status(200).send(tour)
    } catch(e) {
        logger.error(e)
        res.status(500).send(e.message);
    }
})

module.exports = router;
