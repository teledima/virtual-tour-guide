const express = require('express')
const cors = require('cors')
const cookieParser = require('cookie-parser')
const passport = require('passport')

require('dotenv').config()

const { server_port } = require('./constants')
const jwtStrategy = require('./passport_jwt')
const account = require('./account')
const images = require('./images')
const tours = require('./tours')
const hotspots = require('./hotspots')
const scenes = require('./scenes')

const app = express()

passport.use('jwt', jwtStrategy)

app.use(passport.initialize())
app.use(express.json())
app.use(cors())
app.use(cookieParser())
app.use('/account', account)
app.use('/images', images)
app.use('/tours', tours)
app.use('/hotspots', hotspots)
app.use('/scenes', scenes)

app.listen(server_port, '192.168.1.44', () => {
    console.log(`listen http://192.168.1.44:${server_port}`)
})
