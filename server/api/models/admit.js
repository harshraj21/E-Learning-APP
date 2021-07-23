const mongoose = require('mongoose');

const AdmitToken = mongoose.model('AdmitToken', {
    token: {
        trim: true,
        required: true,
        minlength: 5,
    }
});

module.exports = AdmitToken;