const express = require('express')
const router = express.Router()

const { ObjectId } = require('mongodb')
let { mongoClient, db_name} = require('./utils/mongo')

const tourCollection = mongoClient.db(db_name).collection('tours')

router.get('/all', async(req, res) => {
    mongoClient = await mongoClient.connect();
    
    const cursor = tourCollection.find({}, { _id: true, metadata: true }).map((item) => Object.assign({tourId: item._id, metadata: item.metadata}));
    res.status(200).send(await cursor.toArray());
});

router.get('/:tour', async(req, res) => {
    const tour = req.params.tour;
    mongoClient = await mongoClient.connect()

    try {
        if (ObjectId.isValid(tour)) {
            const cursor = tourCollection.aggregate([
                { $match: { _id: new ObjectId(tour) } },
                { $set: { tourId: '$_id' } },
                { $project: { _id: false } }
            ])

            let result = {}
            res = res.status(200)
            if (await cursor.hasNext())
                result = await cursor.next()
            res.send(result)
        }
        else {
            res.status(400).send('incorrect id')
        }
    }
    catch(error) {
        console.log(error)
    }
    finally {
        await mongoClient.close()
    }
})

module.exports = router