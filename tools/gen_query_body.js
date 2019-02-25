const voca = require('voca');
const fs = require('fs');
const md5 = require('blueimp-md5');

let email = 'test@alphacar.io';

let output_file = 'tools/query.json';

let secret = process.env.OTC_SECRET;

let id = process.env.ID;

if (voca.isBlank(secret)) {
    console.error("no secret input! need env var: OTC_SECRET!");
    process.exit();
}

if (voca.isBlank(id)) {
    console.error("no id input! need env var: ID!");
    process.exit();
}

id = new Number(id);

if (!voca.isBlank(process.env.EMAIL)) {
    email = process.env.EMAIL;
}

if (!voca.isBlank(process.env.OUTPUT_FILE)) {
    output_file = process.env.OUTPUT_FILE;
}

const strToSign = 'email='+ email + '&id=' + id + '&secret=' + secret;

const sign = md5(strToSign);

const result = {
    "email": email,
    "id": id,
    "sign": sign,
};

fs.writeFileSync(output_file, JSON.stringify(result), 'utf-8');
