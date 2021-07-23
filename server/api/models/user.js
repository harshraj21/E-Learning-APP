const mongoose = require('mongoose');

const User = mongoose.model('User', {
    isAdmin: {
        type: Boolean,
        default: false,
    },
    name: {
        type: String,
        trim: true,
        required: true,
    },
    dob: {
        type: String,
        trim: true,
        required: true,
    },
    mobileNumber: {
        type: Number,
        trime: true,
        required: true,
    },
    username: {
        type: String,
        required: true,
        minlength: 5,
        maxlength: 10,
        trim: true,
    },
    password: {
        type: String,
        reuired: true,
        trim: true,
        minlength: 5,
        maxlength: 254,
    },
    batch: {
        type: String,
        required: true,
        trim: true,
    },
    validTill: {
        type: Number,
        default: Math.round(new Date().setFullYear(new Date().getFullYear() + 1)),
        trim: true,
    },
    accountActive: {
        type: Boolean,
        default: true,
    }
});

module.exports = User;