const express = require('express')
const router = express.Router()

const { ObjectId } = require('mongodb')
let { mongoClient, tourCollection} = require('./utils/mongo')

router.get('/all', async(req, res) => {
    mongoClient = await mongoClient.connect();
    
    const cursor = tourCollection.find({});
    res.status(200).send(await cursor.toArray());
});

router.get('/:tour', async(req, res) => {
    const tour = req.params.tour;
    mongoClient = await mongoClient.connect()

    try {
        if (ObjectId.isValid(tour)) {
            const cursor = tourCollection.aggregate([
                { $match: { _id: new ObjectId(tour) } },
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

router.patch('/', async(req, res) => {
    mongoClient = await mongoClient.connect();

    const body = req.body['updateBody']
    let updateBody = {}
    if ('title' in body) {
        updateBody['title'] = body['title'];
    } 
    if ('default' in body) {
        updateBody['default'] = {};
        if ('firstScene' in body['default']) {
            updateBody['default']['firstScene'] = new ObjectId(body['default']['firstScene'])
        }
    }

    const updateRes = await tourCollection.updateOne(
        { _id: new ObjectId(req.body['tourId']) },
        { $set: updateBody }
    );
    res.status(200).send(updateRes);
})

module.exports = router