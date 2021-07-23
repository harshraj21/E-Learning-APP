const mongoose = require('mongoose');

const Recorded = mongoose.model('Recorded', {
    subject: {
        type: String,
        required: true,
    },
    title: {
        type: String,
        required: true,
    },
    description: {
        type: String,
        required: true,
    },
    url: {
        type: String,
        required: true,
        trime: true,
    },
    schedule: {
        type: Number,
        required: true,
        trim: true,
    },
    expire: {
        type: Number,
        required: true,
        trim: true,
    },
    batch: {
        type: String,
        required: true,
        trim: true,
    }
});

module.exports = Recorded;