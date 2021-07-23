const express = require('express');
require('./db/mongoose');
const Notice = require('./models/notice');

const app = express();

app.use(express.json());

app.get('/', (req, resp) => {
    resp.send('server running');
});

app.post('/notice', (req, resp) => {
    const notice = new Notice(req.body);
    notice.save().then(() => {
        resp.send(notice);
    }).catch((e) => {
        resp.status(400).send(e);
    });
});

app.get('/notice', (req, resp) => {
    Notice.find({}).then((notices) => {
        resp.send(notices);
    }).catch((e) => {
        resp.status(400).send(e);
    });
});

const port = process.env.PORT || 3000;
app.listen(port, () => {
    console.log(`server running on port ${port}`);
});