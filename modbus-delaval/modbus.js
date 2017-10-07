const SerialPort = require('serialport');
const {ModbusMaster, DATA_TYPES} = require('modbus-rtu');

var async = require('async');

const serialPort = new SerialPort("COM4", {
   baudRate: 9600
});

const master = new ModbusMaster(serialPort);

setInterval(function() {
	var modbus1 = [];
	var modbus2 = [];

	async.parallel({
		async_modbus_1_1 : function(callback) {
			// 4103 Float 1 [oil]
			master.readHoldingRegisters(1, 4103, 2, DATA_TYPES.HEX).then((data) => {
			    // console.log(data);
			    var get_data = data[0];
			    
			    var get_data_a = '0x'+get_data[0]+get_data[1];
			    var get_data_b = '0x'+get_data[2]+get_data[3];
			    var get_data_c = '0x'+get_data[4]+get_data[5];
			    var get_data_d = '0x'+get_data[6]+get_data[7];

			    var get_data_CDAB = Buffer.from([get_data_c, get_data_d, get_data_a, get_data_b]);
			    var get_data_CDAB_float = get_data_CDAB.readFloatBE().toFixed(2) // set 2 decimal
				// console.log(get_data_CDAB)
				console.log('MODBUS ID 1 => OIL : '+get_data_CDAB_float);
				modbus1.push(get_data_CDAB_float);
				callback(null, get_data_CDAB_float);
			}, (err) => {
				console.log(err);
			});
		},
		async_modbus_1_2 : function(callback) {
			// 4106 Float 2 [water]
			master.readHoldingRegisters(1, 4106, 2, DATA_TYPES.HEX).then((data) => {
			    // console.log(data);
			    var get_data = data[0];
			    
			    var get_data_a = '0x'+get_data[0]+get_data[1];
			    var get_data_b = '0x'+get_data[2]+get_data[3];
			    var get_data_c = '0x'+get_data[4]+get_data[5];
			    var get_data_d = '0x'+get_data[6]+get_data[7];

			    var get_data_CDAB = Buffer.from([get_data_c, get_data_d, get_data_a, get_data_b]);
			    var get_data_CDAB_float = get_data_CDAB.readFloatBE().toFixed(2) // set 2 decimal
				// console.log(get_data_CDAB)
				console.log('MODBUS ID 1 => WATER : '+get_data_CDAB_float);
				modbus1.push(get_data_CDAB_float);
				callback(null, get_data_CDAB_float);
			}, (err) => {
				console.log(err);
			});
		},
		async_modbus_2_1 : function(callback) {
			// 4103 Float 1 [oil]
			master.readHoldingRegisters(2, 4103, 2, DATA_TYPES.HEX).then((data) => {
			    // console.log(data);
			    var get_data = data[0];
			    
			    var get_data_a = '0x'+get_data[0]+get_data[1];
			    var get_data_b = '0x'+get_data[2]+get_data[3];
			    var get_data_c = '0x'+get_data[4]+get_data[5];
			    var get_data_d = '0x'+get_data[6]+get_data[7];

			    var get_data_CDAB = Buffer.from([get_data_c, get_data_d, get_data_a, get_data_b]);
			    var get_data_CDAB_float = get_data_CDAB.readFloatBE().toFixed(2) // set 2 decimal
				// console.log(get_data_CDAB)
				console.log('MODBUS ID 2 => OIL : '+get_data_CDAB_float);
				modbus2.push(get_data_CDAB_float);
				callback(null, get_data_CDAB_float);
			}, (err) => {
				console.log(err);
			});
		},
		async_modbus_2_2 : function(callback) {
			// 4106 Float 2 [water]
			master.readHoldingRegisters(2, 4106, 2, DATA_TYPES.HEX).then((data) => {
			    // console.log(data);
			    var get_data = data[0];
			    
			    var get_data_a = '0x'+get_data[0]+get_data[1];
			    var get_data_b = '0x'+get_data[2]+get_data[3];
			    var get_data_c = '0x'+get_data[4]+get_data[5];
			    var get_data_d = '0x'+get_data[6]+get_data[7];

			    var get_data_CDAB = Buffer.from([get_data_c, get_data_d, get_data_a, get_data_b]);
			    var get_data_CDAB_float = get_data_CDAB.readFloatBE().toFixed(2) // set 2 decimal
				// console.log(get_data_CDAB)
				console.log('MODBUS ID 2 => WATER : '+get_data_CDAB_float);
				modbus2.push(get_data_CDAB_float);
				callback(null, get_data_CDAB_float);
			}, (err) => {
				console.log(err);
			});
		}
	}, 
	function(error, result){
		if (error) {
			console.log(error);
		}

		if (result) {
			// console.log(result);
			var resModbus = result;

			var modbus = [modbus1, modbus2];
			console.log(modbus);
		}
	})
	
}, 1000);