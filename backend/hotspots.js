const express = require('express')
const router = express.Router()

const { ObjectId } = require('mongodb')
let { mongoClient, tourCollection} = require('./utils/mongo')

router.delete('/', async(req, res) => {
    const body = req.body;
    mongoClient = await mongoClient.connect()
    const result = await tourCollection.updateOne(
        { 
            _id: new ObjectId(body.tourId),
            "scenes.sceneId": new ObjectId(body.sceneFrom)
        },
        { $pull: { "scenes.$.hotSpots": { sceneId: new ObjectId(body.sceneTo) } } }
    );
    res.status(200).send(result);
})

router.patch('/', async(req, res) => {
    const body = req.body;
    mongoClient = await mongoClient.connect()
    const result = await tourCollection.updateOne(
        {
            _id: new ObjectId(body.tourId),
            "scenes.sceneId": new ObjectId(body.sceneFrom),
        },
        { $set: { "scenes.$.hotSpots.$[elem].latitude": body.latitude, "scenes.$.hotSpots.$[elem].longtitude": body.longtitude } },
        { arrayFilters: [ {"elem.sceneId": new ObjectId(body.sceneTo)} ] }
    )
    res.status(200).send(result);
})

module.exports = router;