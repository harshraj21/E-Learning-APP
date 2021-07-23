const mongoose = require('mongoose');

const uri = 'mongodb+srv://mongo:node1Toor@cluster0.tmsl2.mongodb.net/optimus?retryWrites=true&w=majority';

mongoose.connect(uri, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    useCreateIndex: true
});