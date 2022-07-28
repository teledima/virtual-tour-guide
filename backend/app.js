const express = require('express')
const cors = require('cors')
const cookieParser = require('cookie-parser')
const passport = require('passport')

require('dotenv').config()

const { server_port } = require('./constants')
const routes = require('./routes')
const jwtStrategy = require('./authentication/jwt_strategy')

const app = express()

passport.use('jwt', jwtStrategy)
app.use(passport.initialize())
app.use(express.json())
app.use(cors())
app.use(cookieParser())
app.use('/', routes)


app.listen(server_port, '192.168.1.44', () => {
    console.log(`listen http://192.168.1.44:${server_port}`)
})
