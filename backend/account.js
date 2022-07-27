const passport = require('passport')
const { createHash } = require('crypto')
const express = require('express')


const { salt_length } = require('./constants')
const {getRandomString, getJwtToken, mongo} = require('./utils')
let { mongoClient, userCollection } = mongo

const router = express.Router()

router.post('/sign-up', async(req, res) => {
    const body = req.body;
    mongoClient = await mongoClient.connect()

    const emailSearchResult = await userCollection.findOne(
        { email: body.email }
    )

    if (emailSearchResult) {
        res.status(422).send({error:  'email-exist'})
    } else {
        salt = getRandomString(salt_length)
        const hash = createHash('sha512').update(body.password + salt)
        const insertResult = await userCollection.insertOne({
            name: body.name,
            email: body.email,
            password: hash.digest('hex'),
            salt: salt
        })
        
        if (insertResult.acknowledged) {
            res.status(200).send({
                name: body.name,
                email: body.email
            })
        } else {
            res.status(422).send({error: 'register-not-completed'})
        }
    }
})

router.post('/login', async(req, res) => {
    const body = req.body
    mongoClient = await mongoClient.connect()
    
    const userSearch = await userCollection.findOne(
        { email: body.email }
    )

    if (userSearch) {
        const salt = userSearch.salt
        const password = userSearch.password

        if (createHash('sha512').update(body.password + salt).digest('hex') === password) {
            res.cookie('jwt', getJwtToken(userSearch), {maxAge: 31536000000, httpOnly: true}).sendStatus(204)
        } else {
            res.status(401).send('incorrect-password')
        }
    } else {
        res.status(404).send('user-not-found')
    }
})

router.post('/logout', passport.authenticate('jwt', { session: false }), async(req, res) => {
    res.clearCookie('jwt').sendStatus(204)
})

module.exports = router;
