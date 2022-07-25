const passportJwt = require('passport-jwt')

const JwtStrategy = passportJwt.Strategy,
      ExtractJwt  = passportJwt.ExtractJwt

let { mongoClient, userCollection } = require('./utils/mongo')

const opts = {
    jwtFromRequest: ExtractJwt.fromExtractors([
        function(req) {
            if (req && req.cookies) {
                return req.cookies['jwt'];
            }
        }
    ]),
    secretOrKey: process.env.JWT_SECRET || 'secret',
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
