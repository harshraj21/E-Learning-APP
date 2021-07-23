const mongoose = require('mongoose');

const Result = mongoose.model('Result', {
    totalquestions: {
        type: Number,
        reuired: true,
        trim: true,
    },
    attemptedquestions: {
        type: Number,
        required: true,
        trim: true,
    },
    correctquestions: {
        type: Number,
        required: true,
        trim: true,
    },
    marksperques: {
        type: Number,
        required: true,
        trim: true,
    },
    negativemarks: {
        type: Number,
        required: true,
        trim: true,
    },
    dateofexam: {
        type: Number,
        required: true,
        trim: true,
    }
});

module.exports = Result;