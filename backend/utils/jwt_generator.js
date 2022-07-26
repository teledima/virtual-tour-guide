const jwt = require('jsonwebtoken')

const { jwt_secret } = require('../constants')

module.exports = function getJwtToken(user) {
    return jwt.sign(
        { email: user.email },
        jwt_secret,
        { algorithm: 'HS256' }
    )
}
