const express = require('express');
const { execSync } = require('child_process')
const cors = require('cors')
const bodyParser = require('body-parser')
const fs = require('fs')
const { v4: uuidv4 } = require('uuid');

const app = express()
//Define port
const port = 3001

const DIR_CAPTCHAS = `./captchas`;
//Define request response in root URL (/)

app.use(cors())
console.log(__dirname)

app.use(bodyParser.json());       // to support JSON-encoded bodies
app.use(bodyParser.urlencoded({     // to support URL-encoded bodies
    extended: true
}));
app.get('/test', function (req, res) {
    res.send('Hello World!')
})

app.post('/valid', async (req, res) => {
    const image = req.body.image;
    if (!image) {
        return 'not found base64'
    }
    var base64Data = image.replace(/^data:image\/png;base64,/, "");

    if (!fs.existsSync(`${DIR_CAPTCHAS}`)) {
        fs.mkdirSync(`${DIR_CAPTCHAS}`);
    }

    const fileName = `${DIR_CAPTCHAS}/${uuidv4()}.png`;
    await fs.writeFileSync(fileName, base64Data, 'base64', function (err) {
        console.log(err);
    });

    const captcha = await execSync(
        `Rscript resolverCaptcha.R "${fileName}"`,
        { stdio: ['pipe', 'pipe', 'ignore'] }
    ).toString();

    await fs.unlinkSync(fileName);
    res.send({
        code: captcha
    })
})
//Launch listening server on port 3000
app.listen(port, function () {
    console.log('app listening on port ${port}!')
})