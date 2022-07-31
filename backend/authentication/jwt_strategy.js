const passportJwt = require('passport-jwt')

const JwtStrategy = passportJwt.Strategy,
      ExtractJwt  = passportJwt.ExtractJwt

const { jwt_secret } = require('../constants')
const { User } = require('../models')

const opts = {
    jwtFromRequest: ExtractJwt.fromExtractors([
        function(req) {
            if (req && req.cookies) {
                return req.cookies['jwt'];
            }
        }
    ]),
    secretOrKey: jwt_secret,
    algorithms: ['HS256']
}

module.exports = new JwtStrategy(opts, async(jwt_payload, done) => {
    const user = await User.findOne({email: jwt_payload.email})
    if (user) {
        return done(null, user.toObject())
    } else {
        return done(null, false)
    }
})
