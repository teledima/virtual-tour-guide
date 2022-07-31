const mongoose = require('mongoose')

const { getRandomString } = require('../utils')
const { salt_length } = require('../constants')

const userSchema = new mongoose.Schema({
    name: { type:String, required: true },
    email: { type:String, required: true },
    password: { type:String, required: true },
    salt: { type: String, default:  getRandomString(salt_length)}
}, { collection: 'users' })

module.exports = mongoose.model('User', userSchema)
