var bcrypt = require('bcrypt-nodejs');
var pass = bcrypt.hashSync("adminbhg", null, null);
console.log(pass);