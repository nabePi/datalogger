const SerialPort = require('serialport');
const {ModbusMaster, DATA_TYPES} = require('modbus-rtu');

const serialPort = new SerialPort("COM4", {
   baudRate: 9600
});

const master = new ModbusMaster(serialPort);

setInterval(function() {

	// MODBUS ID 1
	
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
	}, (err) => {
		console.log(err);
	});

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
	}, (err) => {
		console.log(err);
	});

	// MODBUS ID 2
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
	}, (err) => {
		console.log(err);
	});

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
	}, (err) => {
		console.log(err);
	});

}, 1000);