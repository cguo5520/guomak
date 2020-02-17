const fs = require('fs');

const logic = fs.readFileSync('guomak_logic.txt').toString();

const level3Txt = fs.readFileSync('level3').toString();
const level3Bindings = level3Txt.split('\n').map(line => line.split(' '));

const level3CodeArr = level3Bindings.map(([key, ...output]) =>
  `] & ${key}::${output.join(' ')}`
);

const finalLevel3Code = level3CodeArr.join('\n');

fs.writeFileSync('guomak.ahk', logic + finalLevel3Code)