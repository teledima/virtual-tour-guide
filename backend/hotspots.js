const express = require('express')
const router = express.Router()

const { ObjectId } = require('mongodb')
let { mongoClient, db_name} = require('./utils/mongo')

const tourCollection = mongoClient.db(db_name).collection('tours')

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

module.exports = router;