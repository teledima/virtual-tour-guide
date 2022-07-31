const express = require('express')
const cors = require('cors')
const cookieParser = require('cookie-parser')
const morgan = require('morgan')
const passport = require('passport')
const mongoose = require('mongoose')

require('dotenv').config()

const { server_port, mongo_host, mongo_port, mongo_db, mongo_user, mongo_password } = require('./constants')
const routes = require('./routes')
const jwtStrategy = require('./authentication/jwt_strategy')
const { logger } = require('./utils')

const app = express()


passport.use('jwt', jwtStrategy)
app.use(passport.initialize())
app.use(express.json())
app.use(cors())
app.use(cookieParser())
if (process.env.NODE_ENV != 'production') {
    app.use(morgan('dev'))
}
app.use('/', routes)


app.listen(server_port, '192.168.1.44', async() => {
    logger.info('Start connecting to mongodb')
    await mongoose.connect(`mongodb://${mongo_host}:${mongo_port}`, {
        dbName: mongo_db,
        user: mongo_user,
        pass: mongo_password
    })
    logger.info('Successful connect to mongodb')
    logger.info(`Listen http://192.168.1.44:${server_port}`)
})
