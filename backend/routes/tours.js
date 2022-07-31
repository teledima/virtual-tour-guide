const passport = require('passport')
const express = require('express')
const { CastError } = require('mongoose')


const { logger } = require('../utils')
const { Tour } = require('../models')

const router = express.Router()
router.use(passport.authenticate('jwt', {session: false}))

router.post('/', async(req, res) => {
    const tour = await new Tour({...req.body, owner: req.user._id}).save()
    res.status(200).send(tour.toJSON({ versionKey: false }));
});

router.get('/all', async(req, res) => {
    res.status(200).send(await Tour.find({
        owner: req.user._id
    }));
});

router.get('/:tour', async(req, res) => {
    const tourId = req.params.tour;

    try {
        const tour = await Tour.findById(tourId)
        res.status(200).send(tour.toJSON({ versionKey: false }))
    } catch (e) {
        logger.error(JSON.stringify(e))
        if (e instanceof CastError) {
            res.sendStatus(404)
        } else {
            res.sendStatus(500)
        }
    }
})

router.patch('/', async(req, res) => {
    try {
        await Tour.findByIdAndUpdate(req.body.tourId, req.body.updateBody)
        const tour = await Tour.findById(req.body.tourId)
        res.status(200).send(tour.toJSON({ versionKey: false }));
    } catch(e) {
        console.log(e)
        logger.error(JSON.stringify(e))
        if (e instanceof CastError) {
            res.sendStatus(404)
        } else {
            res.sendStatus(500)
        }
    }
})

module.exports = router
