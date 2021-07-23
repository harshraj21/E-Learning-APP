const mongoose = require('mongoose');

const Live = mongoose.model('Live', {
    timestamp: {
        type: Number,
        required: true,
        trim: true,
    },
    batch: {
        type: String,
        reuired: true,
        trim: true,
    },
    toppic: {
        type: String,
        reuired: true,
    },
    duration: {
        type: Number,
        default: 1,
        trim: true
    },
    breaf: {
        type: String,
        trim: true,
        required: true,
    }
});

module.exports = Live;