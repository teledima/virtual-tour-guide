const passportJwt = require('passport-jwt')

const JwtStrategy = passportJwt.Strategy,
      ExtractJwt  = passportJwt.ExtractJwt

const { jwt_secret } = require('./constants')

let { mongoClient, userCollection } = require('./utils/mongo')

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
    mongoClient = await mongoClient.connect()
    const userSearch = await userCollection.findOne({email: jwt_payload.email})
    if (userSearch) {
        return done(null, userSearch.email)
    } else {
        return done(null, false)
    }
})
