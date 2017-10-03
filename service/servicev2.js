var app = require('http').createServer(handler);
var fs = require('fs');
var mysql = require('mysql');
var io = require('socket.io').listen(app);
var async = require('async');
var dbconfig = require('../config/database');
var pool = mysql.createPool(dbconfig.connectionReading);
var poolv2 = mysql.createPool(dbconfig.connection);
var connectionsArray = [];
var POLLING_INTERVAL = 1000;
var pollingTimer;

var source_input = ["analog", "rs485", "pulse"];
var type_input = ["LEVEL", "PRESSURE", "TEMPERATURE", "FLOW", "H2S"];

function handler(req, res) {
	fs.readFile(__dirname + '/client.html', function(err, data){
		if (err) {
			console.log(err);
			res.writeHead(500);
			return res.end('Error loading client.html');
		}
		res.writeHead(200);
		res.end(data);
	})
};

var calcRawData = function(valueRaw, lowMA, highMA, lowValue, highValue, offset1) {
	var resCalcRawData = (((((valueRaw + offset1) - lowMA) / (highMA - lowMA)) * (highValue - lowValue)) + lowValue);
	return resCalcRawData;
}

var calcRawRs485 = function(valueRaw) {
	var unpackValueRaw = valueRaw.split('/');
	var resCalcRawRs485 = unpackValueRaw[1];
	return resCalcRawRs485;
}

var calcRawFlow = function(valueRaw) {
	var resCalcRawFlow = 60 * valueRaw;
	return resCalcRawFlow;
}

var calcRawFlowTot = function(valueRaw, offset1) {
	var resCalcRawFlow = valueRaw + offset1;
	return resCalcRawFlow;
}

var cacheRawData = [];

var pollingLoop = function() {
	var data = {};
	var data_process = {};
	
	var all_control_sensor = [];
	
	var all_sensors_raw = [];
	var all_sensors_calc = [];

	var all_alarm = {};
	var all_alarm_raw = {};
	var all_alarm_calc = {};

	var all_raw_data = [];
	var all_raw_rs485 = [];
	var all_raw_flow = [];
	var all_raw_flow_tot = [];

	var push_datas = [];
	var push_datas_calc = [];

	// async
	async.parallel({
		async_sensors_raw : function(callback) {
			poolv2.getConnection(function(err, connection) {
				if (err) {
					console.log(err);
				}
				connection.query('SELECT * FROM sensors_raw ORDER BY type')
				.on('error', function(err) {
					console.log(err);
				})
				.on('result', function(res) {
					// all_control_sensor.push(res);
					all_sensors_raw.push(res);
				})
				.on('end', function() {
					// data.control_sensor = all_control_sensor;
					data.all_sensors_raw = all_sensors_raw
					callback(null, 1);
					connection.release();
				});
			});
		},
		async_sensors_calc: function(callback) {
			poolv2.getConnection(function(err, connection) {
				if (err) {
					console.log(err);
				}
				connection.query('SELECT * FROM sensors_calc')
				.on('error', function(err) {
					console.log(err);
				})
				.on('result', function(res) {
					// all_control_sensor.push(res);
					all_sensors_calc.push(res);
				})
				.on('end', function() {
					// data.control_sensor = all_control_sensor;
					data.all_sensors_calc = all_sensors_calc
					callback(null, 1);
					connection.release();
				});
			});
		},
		async_sensor_alarm: function(callback) {
			poolv2.getConnection(function(err, connection) {
				if (err) {
					console.log(err);
				}
				connection.query('SELECT * FROM sensor_alarm')
				.on('error', function(err) {
					console.log(err);
				})
				.on('result', function(res) {
					// all_control_sensor.push(res);
					// all_sensors_calc.push(res);
					console.log(res.is_calc);
					if (res.is_calc > 0) {
						var keyAlarmRaw = 'ALARM_CALC_'+res.id;

						var valueAlaramRaw = {};
						valueAlaramRaw.channel_LL = res.channel_LL;
						valueAlaramRaw.channel_L = res.channel_L;
						valueAlaramRaw.channel_H = res.channel_H;
						valueAlaramRaw.channel_HH = res.channel_HH;

						all_alarm[keyAlarmRaw] = valueAlaramRaw;
					} else {
						var keyAlarmRaw = 'ALARM_RAW_'+res.id;

						var valueAlaramRaw = {};
						valueAlaramRaw.channel_LL = res.channel_LL;
						valueAlaramRaw.channel_L = res.channel_L;
						valueAlaramRaw.channel_H = res.channel_H;
						valueAlaramRaw.channel_HH = res.channel_HH;

						all_alarm[keyAlarmRaw] = valueAlaramRaw;
					}
				})
				.on('end', function() {
					// data.control_sensor = all_control_sensor;
					// data.all_sensors_calc = all_sensors_calc
					
					console.log(all_alarm);
					callback(null, 1);
					connection.release();
				});
			});
		},
		async_raw_data : function(callback) {
			pool.getConnection(function(err, connection) {
				if (err) {
					console.log(err);
				}
				connection.query('SELECT * FROM app_raw_data')
				.on('error', function(err) {
					console.log(err);
				})
				.on('result', function(res) {
					all_raw_data.push(res);
				})
				.on('end', function() {
					data.raw_data = all_raw_data;
					callback(null, 1);
					connection.release();
				});
			});
		},
		async_raw_rs485 : function(callback) {
			pool.getConnection(function(err, connection) {
				if (err) {
					console.log(err);
				}
				connection.query('SELECT * FROM app_raw_rs485')
				.on('error', function(err) {
					console.log(err);
				})
				.on('result', function(res) {
					all_raw_rs485.push(res);
				})
				.on('end', function() {
					data.raw_rs485 = all_raw_rs485;
					callback(null, 1);
					connection.release();
				});
			});
		},
		async_raw_flow : function(callback) {
			pool.getConnection(function(err, connection) {
				if (err) {
					console.log(err);
				}
				connection.query('SELECT * FROM app_raw_flow')
				.on('error', function(err) {
					console.log(err);
				})
				.on('result', function(res) {
					all_raw_flow.push(res);
				})
				.on('end', function() {
					data.raw_flow = all_raw_flow;
					callback(null, 1);
					connection.release();
				});
			});
		},
		async_raw_flow_tot : function(callback) {
			pool.getConnection(function(err, connection) {
				if (err) {
					console.log(err);
				}
				connection.query('SELECT * FROM app_raw_flow_tot')
				.on('error', function(err) {
					console.log(err);
				})
				.on('result', function(res) {
					all_raw_flow_tot.push(res);
				})
				.on('end', function() {
					data.raw_flow_tot = all_raw_flow_tot;
					callback(null, 1);
					connection.release();
				});
			});
		}
	},
	function(err, results) {
		if (err) {
			console.log(err);
		}

		if (results) {
			
			if (data.raw_data.length == 0) {
				data.raw_data = cacheRawData
			} else {
				cacheRawData = all_raw_data;	
			}

			var array_type = ['LEVEL', 'PRESSURE', 'TEMPERATURE', 'FLOW', 'H2S', 'RPM', 'GAS'];

			var data_rs485 = {};

			// var data_array_rs485 = [];

			// console.log(data.all_sensors_raw);
			// console.log(data.all_sensors_raw.length);

			for (var i = 0; i < data.all_sensors_raw.length;  i++) {
				var sensors_raw_id = data.all_sensors_raw[i].id;
				var sensors_raw_name = data.all_sensors_raw[i].name;
				var sensors_raw_source = data.all_sensors_raw[i].source;
				var sensors_raw_chanel = data.all_sensors_raw[i].chanel;
				var sensors_raw_type = data.all_sensors_raw[i].type;
				var sensors_raw_low_ma = data.all_sensors_raw[i].low_ma;
				var sensors_raw_high_ma = data.all_sensors_raw[i].high_ma;
				var sensors_raw_value_min = data.all_sensors_raw[i].value_min;
				var sensors_raw_value_max = data.all_sensors_raw[i].value_max;
				var sensors_raw_unit = data.all_sensors_raw[i].unit;
				var sensors_raw_low_ma_calibration = data.all_sensors_raw[i].low_ma_calibration;
				var sensors_raw_high_ma_calibration = data.all_sensors_raw[i].high_ma_calibration;
				var sensors_raw_value_min_calibration = data.all_sensors_raw[i].value_min_calibration;
				var sensors_raw_value_max_calibration = data.all_sensors_raw[i].value_max_calibration;
				var sensors_raw_linearity = data.all_sensors_raw[i].linearity;
				var sensors_raw_offset = data.all_sensors_raw[i].offset;

				if (sensors_raw_low_ma_calibration != null) {
					sensors_raw_low_ma = sensors_raw_low_ma_calibration;
				}
				if (sensors_raw_high_ma_calibration != null) {
					sensors_raw_high_ma = sensors_raw_high_ma_calibration;
				}
				if (sensors_raw_value_min_calibration != null) {
					sensors_raw_value_min = sensors_raw_value_min_calibration;
				}
				if (sensors_raw_value_max_calibration != null) {
					sensors_raw_value_max = sensors_raw_value_max_calibration;
				}

				if (sensors_raw_source == 1) {
					var field_raw_data = 's'+sensors_raw_chanel;
					var sensor_valueRaw = data.raw_data[0][field_raw_data];
					var sensor_dateRecorded = data.raw_data[0]['date_record'];
					var sensor_value = calcRawData(sensor_valueRaw, sensors_raw_low_ma, sensors_raw_high_ma, sensors_raw_value_min, sensors_raw_value_max, sensors_raw_offset);
					data_process['analog_'+sensors_raw_chanel] = [sensors_raw_name, array_type[sensors_raw_type], sensors_raw_id];
				} else if (sensors_raw_source == 2) {
					var field_raw_rs485 = 's'+sensors_raw_chanel;
					var sensor_valueRaw = data.raw_rs485[0][field_raw_rs485];
					var sensor_dateRecorded = data.raw_data[0]['date_record'];
					var sensor_value = calcRawRs485(sensor_valueRaw, sensors_raw_offset);
					data_rs485[sensors_raw_chanel] = [sensors_raw_name, array_type[sensors_raw_type]];
				} else {
					if (sensors_raw_type == 3) {
						var field_raw_flow_tot = 's'+sensors_raw_chanel;
						var sensor_valueRaw = data.raw_flow[0][field_raw_flow_tot];
						var sensor_dateRecorded = data.raw_data[0]['date_record'];
						var sensor_value = calcRawFlowTot(sensor_valueRaw, sensors_raw_offset);
					} else {
						var field_raw_flow = 's'+sensors_raw_chanel;
						var sensor_valueRaw = data.raw_flow[0][field_raw_flow];
						var sensor_dateRecorded = data.raw_data[0]['date_record'];
						var sensor_value = calcRawFlow(sensor_valueRaw, sensors_raw_offset);
						data_process['pulse_'+sensors_raw_chanel] = [sensors_raw_name, array_type[sensors_raw_type], sensors_raw_id];
					}
				}

				// Sensors Calc Sutff
				var name_variable = sensors_raw_name.replace(/ /g,"_").toLowerCase();
				this[name_variable] = parseFloat(sensor_value);
				// End of Sensor Calc Stuff

				var push_data = {};

				push_data.sensor_id = sensors_raw_id;
				push_data.sensor_name = sensors_raw_name;
				push_data.sensor_value = parseFloat(sensor_value);
				push_data.sensor_dateRecorded = localeDateTime(sensor_dateRecorded);
				push_data.sensor_unit = sensors_raw_unit;
				push_data.sensor_type = sensors_raw_type;

				var push_dataKeyId = {};

				push_dataKeyId.sensor_id = sensors_raw_id;
				push_dataKeyId.sensor_name = sensors_raw_name;
				push_dataKeyId.sensor_value = parseFloat(sensor_value);
				push_dataKeyId.sensor_dateRecorded = localeDateTime(sensor_dateRecorded);
				push_dataKeyId.sensor_unit = sensors_raw_unit;
				push_dataKeyId.sensor_type = sensors_raw_type;
				data_process[sensors_raw_id] = push_dataKeyId;

				data_process[sensors_raw_name] = sensor_value;

				data_process.data_all_rs485 = data_rs485;

				push_datas.push(push_data);

			}

			// console.log(data.all_sensors_calc);

			for (var i = 0;  i < data.all_sensors_calc.length; i++) {
				var sensors_calc_id = data.all_sensors_calc[i].id;
				var sensors_calc_name = data.all_sensors_calc[i].name;
				var sensors_calc_variable = data.all_sensors_calc[i].variable;

				var sensors_calc_variable_customize = data.all_sensors_calc[i].variable_customize;
				var sensors_calc_variable_customize_json = JSON.parse(sensors_calc_variable_customize);
				
				Object.keys(sensors_calc_variable_customize_json).forEach(function(key){
					var name_variable_customize = key;
					this[name_variable_customize] = parseFloat(sensors_calc_variable_customize_json[key]);
				});

				var sensors_calc_formula = data.all_sensors_calc[i].formula;
				
				try { 
					var sensors_calc_results = eval(sensors_calc_formula.replace(/ /g,"")); 
				} catch(e) {
					var sensors_calc_results = null;
				};

				// initialize senosors calc for varaible
				var name_variable_calc_useable = sensors_calc_name.replace(/ /g,"_").toLowerCase();
				this[name_variable_calc_useable] = parseFloat(sensors_calc_results);
				// end of initialize

				var push_data_calc = {};
				push_data_calc.sensor_id = sensors_calc_id;
				push_data_calc.sensor_name = sensors_calc_name;
				push_data_calc.sensor_variable = sensors_calc_variable;
				push_data_calc.sensor_variable_customize = sensors_calc_variable_customize;
				push_data_calc.sensor_formula = sensors_calc_formula;
				push_data_calc.sensor_value = parseFloat(sensors_calc_results);

				push_datas_calc.push(push_data_calc);

				var push_dataCalcKeyId = {};

				var keyForCalc = 'calc_'+sensors_calc_id;
				push_dataCalcKeyId.sensor_id = sensors_calc_id;
				push_dataCalcKeyId.sensor_name = sensors_calc_name;
				push_dataCalcKeyId.sensor_value = parseFloat(sensors_calc_results);
				push_dataCalcKeyId.sensor_type = 7;
				data_process[keyForCalc] = push_dataCalcKeyId;
			}
			
			// RAW DATA BEFORE CALC / ORIGINAL FROM SENSORS
			data_process.raw_data = all_raw_data[0];
			data_process.raw_rs485 = all_raw_rs485[0];
			data_process.raw_flow = all_raw_flow[0];
			data_process.raw_flow_tot = all_raw_flow_tot[0];

			data_process.push = push_datas;
			data_process.push_calc = push_datas_calc;

			updateSockets({
				data : data_process
			});
		}

		// console.log(connectionsArray.length);
		if (connectionsArray.length > 0) {
			pollingTimer = setTimeout(pollingLoop, POLLING_INTERVAL);	
		}
		
	});		
};

var updateSockets = function(data) {
	// console.log(data);
	data.time = new Date();
	console.log('Pushing new data to the clients connected ( connections amount = %s ) - %s', connectionsArray.length , data.time.toLocaleString());
	connectionsArray.forEach(function(tmpSocket) {
		tmpSocket.volatile.emit('notification', data);
		// console.log(data);
	});
};

var localeDateTime = function(date_time) {
	var dateTime = new Date(date_time);
	return dateTime.toLocaleString();
}


io.sockets.on('connection', function(socket) {
	console.log('Number of connections : '+ connectionsArray.length);
	if (!connectionsArray.length) {
		pollingLoop();
	}

	socket.on('disconnect', function() {
		var socketIndex = connectionsArray.indexOf(socket);
		console.log('socketID = %s got disconnected', socketIndex);
		if (~socketIndex) {
			connectionsArray.splice(socketIndex, 1);
		}
	});

	console.log('A new socket is connected !');
	connectionsArray.push(socket);
});

app.listen(8001);
console.log('SERVICE_READY [OK] [http://localhost:8001]');