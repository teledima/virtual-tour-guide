const express = require('express')
const cors = require('cors')
const images = require('./images')
const tours = require('./tours')
const hotspots = require('./hotspots')

const app = express()
const port = process.env.PORT || 8080

app.use(express.json())
app.use(cors())
app.use('/images', images)
app.use('/tours', tours)
app.use('/hotspots', hotspots)

app.listen(port, '192.168.1.44', () => {
    console.log(`listen http://192.168.1.44:${port}`)
})
