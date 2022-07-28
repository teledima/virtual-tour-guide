const express = require('express')

const account = require('./account')
const images = require('./images')
const tours = require('./tours')
const hotspots = require('./hotspots')
const scenes = require('./scenes')

const router = express.Router()

router.use('/account', account)
router.use('/images', images)
router.use('/tours', tours)
router.use('/hotspots', hotspots)
router.use('/scenes', scenes)

module.exports = router
