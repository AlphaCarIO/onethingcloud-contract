const voca = require('voca');
const ethers = require('ethers');
const fs = require('fs');
const md5 = require('blueimp-md5');

let email = 'test@alphacar.io';

let bin_file_path = 'build/OrderManager/build_OrderManager_sol_OrderManager.bin';

let param_val = '0x5875bf81ec70e9c0bce8345aa34b74ad7785dbb6';

let output_file = 'tools/deploy.json';

let secret = process.env.OTC_SECRET;

if (voca.isBlank(secret)) {
    console.error("no secret input! need env var: OTC_SECRET!");
    process.exit();
}

if (!voca.isBlank(process.env.ADDRESS)) {
    param_val = process.env.ADDRESS;
}

if (!voca.isBlank(process.env.EMAIL)) {
    email = process.env.EMAIL;
}

if (!voca.isBlank(process.env.OUTPUT_FILE)) {
    output_file = process.env.OUTPUT_FILE;
}

if (!voca.isBlank(process.env.BIN_FILEPATH)) {
    bin_file_path = process.env.BIN_FILEPATH;
}

if (!voca.isBlank(process.env.PARAM_VAL)) {
    param_val = process.env.PARAM_VAL;
}

var abiCoder = new ethers.utils.AbiCoder();

let param_bytecode = abiCoder.encode(['address'], [param_val]);

console.log('param_bytecode:', param_bytecode);

let bin_file = fs.readFileSync(bin_file_path, 'utf-8');

const strToSign = 'email='+ email + '&bytecode=' + bin_file 
    + '&params=' + param_bytecode + '&secret=' + secret;

const sign = md5(strToSign);

const result = {
    "email": email,
    "bytecode": bin_file,
    "params": param_bytecode,
    "sign": sign,
};

fs.writeFileSync('tools/deploy_debug.txt', strToSign, 'utf-8');
fs.writeFileSync(output_file, JSON.stringify(result), 'utf-8');
