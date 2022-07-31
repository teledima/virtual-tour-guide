const passport = require('passport')
const { createHash } = require('crypto')
const express = require('express')


const { getJwtToken, logger } = require('../utils')

const { User } = require('../models')

const router = express.Router()

router.post('/sign-up', async(req, res) => {
    const body = req.body;

    const user = await User.findOne(
        { email: body.email }
    )

    if (user) {
        res.status(422).send({error:  'email-exist'})
    } else {
        try {
            const newUser = new User({email: body.email, name: body.name})
            newUser.password = createHash('sha512').update(body.password + newUser.salt).digest('hex')
            await newUser.save()
            
            res.status(200).send({
                name: body.name,
                email: body.email
            })
        } catch(e) {
            logger.error(e)
            const errors = Object.values(e.errors).map((item) => item.properties.message)
            res.status(500).send({errors})
        }
    }
})

router.post('/login', async(req, res) => {
    const body = req.body
    
    const user = await User.findOne(
        { email: body.email }
    )

    if (user) {
        const salt = user.salt
        const password = user.password

        if (createHash('sha512').update(body.password + salt).digest('hex') === password) {
            res.cookie('jwt', getJwtToken(user), {maxAge: 31536000000, httpOnly: true}).sendStatus(204)
        } else {
            res.status(401).send('incorrect-password')
        }
    } else {
        res.sendStatus(404)
    }
})

router.post('/logout', passport.authenticate('jwt', { session: false }), async(req, res) => {
    res.clearCookie('jwt').sendStatus(204)
})

module.exports = router;
