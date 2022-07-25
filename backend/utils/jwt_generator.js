const jwt = require('jsonwebtoken')

module.exports = function getJwtToken(user) {
    return jwt.sign(
        { email: user.email },
        'secret',
        { algorithm: 'HS256' }
    )
}
