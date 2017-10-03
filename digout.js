// RUN DIGOUT_2
// var exec = require('child_process').exec;
// var result = '';
// var child = exec('DIGOUT_2.exe');
// child.stdout.on('data', function(data) {
//     result += data;
// });
// child.on('close', function() {
//     console.log('done');
//     console.log(result);
// });


// REGESTRY WINDOWS FOR DIGOUT
var Key = require('windows-registry').Key;
var windef = require('windows-registry').windef;
var key = new Key(windef.HKEY.HKEY_CURRENT_USER, 'Software', windef.KEY_ACCESS.KEY_ALL_ACCESS);

try {
	
	var doutKey = key.openSubKey('dau_a2\\dout\\dout', windef.KEY_ACCESS.KEY_ALL_ACCESS);
	var value = doutKey.getValue('dout');
	console.log(value);

} catch (e) {

	var createdKey1 = key.createSubKey('dau_a2', windef.KEY_ACCESS.KEY_ALL_ACCESS);
	var key1 = new Key(windef.HKEY.HKEY_CURRENT_USER, 'Software\\dau_a2', windef.KEY_ACCESS.KEY_ALL_ACCESS);

	var createdKey2 = key1.createSubKey('dout', windef.KEY_ACCESS.KEY_ALL_ACCESS);
	var key2 = new Key(windef.HKEY.HKEY_CURRENT_USER, 'Software\\dau_a2\\dout', windef.KEY_ACCESS.KEY_ALL_ACCESS);

	var createdKey3 = key2.createSubKey('dout', windef.KEY_ACCESS.KEY_ALL_ACCESS);
	var key3 = new Key(windef.HKEY.HKEY_CURRENT_USER, 'Software\\dau_a2\\dout\\dout', windef.KEY_ACCESS.KEY_ALL_ACCESS);

	var setMainKey = key3.setValue('dout', windef.REG_VALUE_TYPE.REG_SZ, '00000000');
}


// Run Administrator
// var utils = require('windows-registry').utils;
// utils.elevate('C:\\Program Files\\nodejs\\node.exe', 'digout.js', function (err, result) {
// 	console.log(result);
// }); 