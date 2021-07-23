const mongoose = require('mongoose');

const Notice = mongoose.model('Notice', {
    datestamp: {
        type: Number,
        default: Math.round(new Date()),
        trim: true,
    },
    title: {
        type: String,
        required: true,
    },
    message: {
        type: String,
        required: true,
    },
    batch: {
        type: String,
        required: true,
        trim: true,
    }
});

module.exports = Notice;