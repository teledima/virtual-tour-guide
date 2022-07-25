const passport = require('passport')
const express = require('express')
const router = express.Router()

const { ObjectId } = require('mongodb')
let { mongoClient, tourCollection} = require('./utils/mongo')

router.use(passport.authenticate('jwt', { session: false }))

router.post('/', async(req, res) => {
    const body = req.body;
    mongoClient = await mongoClient.connect()
    const result = await tourCollection.updateOne(
        { 
            _id: new ObjectId(body.tourId),
            "scenes.sceneId": new ObjectId(body.sceneId)
        },
        { $push: { "scenes.$.hotSpots": body.hotspot } }
    );
    res.status(200).send(result);
})

router.delete('/', async(req, res) => {
    const body = req.body;
    mongoClient = await mongoClient.connect()
    const result = await tourCollection.updateOne(
        { 
            _id: new ObjectId(body.tourId),
            "scenes.sceneId": new ObjectId(body.sceneId)
        },
        { $pull: { "scenes.$.hotSpots": { latitude: body.latitude, longtitude: body.longtitude } } }
    );
    res.status(200).send(result);
})

router.patch('/', async(req, res) => {
    const body = req.body;
    mongoClient = await mongoClient.connect()
    const result = await tourCollection.updateOne(
        {
            _id: new ObjectId(body.tourId),
            "scenes.sceneId": new ObjectId(body.sceneId),
        },
        { $set: { "scenes.$.hotSpots.$[elem].latitude": body.latitude, "scenes.$.hotSpots.$[elem].longtitude": body.longtitude } },
        { arrayFilters: [ {"elem.latitude": body.hotspot.latitude, "elem.longtitude": body.hotspot.longtitude } ] }
    )
    res.status(200).send(result);
})

module.exports = router;