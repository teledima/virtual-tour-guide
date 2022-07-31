const mongoose = require('mongoose')

const hotspotShema = new mongoose.Schema({
    type: { type: String, required: true },
    latitude: { type: Number, min: -90, max: 90, required: true },
    longtitude: { type: Number, min: -180, max: 180, required: true },
    scene: { type: mongoose.Schema.Types.ObjectId, ref: 'Tour.scenes' }
})

const sceneSchema = new mongoose.Schema({
    title: String,
    panorama: String,
    hotSpots: [hotspotShema]
});

const defaultSceneSchema = new mongoose.Schema({
    firstScene: { type: mongoose.Schema.Types.ObjectId, ref: 'Tour.scenes' }
})

const tourSchema = new mongoose.Schema({
    title: { type: String, required: true },
    scenes: { type: [sceneSchema], default: [] },
    default: { 
        type: defaultSceneSchema,
        get: (value) => {
            if (value) {
                return value;
            } else {
                return this.scenes.length > 0 ? this.scenes[0] : null;
            }
        }
    },
    owner: { type: mongoose.Schema.Types.ObjectId, ref: 'User' }
}, { collection: 'tours' })

module.exports = mongoose.model('Tour', tourSchema)
