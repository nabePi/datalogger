var app = require('http').createServer(handler);
var fs = require('fs');
var mysql = require('mysql');
var io = require('socket.io').listen(app);
var async = require('async');
var dbconfig = require('../config/database');
var pool = mysql.createPool(dbconfig.connectionReading);
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

var calcRawData = function(valueRaw, lowMA, highMA, lowValue, highValue, offset1, coefficient) {
	var resCalcRawData = (((((valueRaw + offset1) - lowMA) / (highMA - lowMA)) * (highValue - lowValue)) + lowValue) * coefficient;
	return resCalcRawData;
}

var calcRawRs485 = function(valueRaw, coefficient, offset1, offset2) {
	var unpackValueRaw = valueRaw.split('/');
	var resCalcRawRs485 = (unpackValueRaw[1] * coefficient) + offset1 + offset2;
	return resCalcRawRs485;
}

var calcRawFlow = function(valueRaw, coefficient, offset1) {
	var resCalcRawFlow = (60 * valueRaw * coefficient) + offset1;
	return resCalcRawFlow;
}

var calcRawFlowTot = function(valueRaw, coefficient, offset1) {
	var resCalcRawFlow = (valueRaw * coefficient) + offset1;
	return resCalcRawFlow;
}

var cacheRawData = [];

var pollingLoop = function() {
	var data = {};
	var data_process = {};
	var all_control_sensor = [];
	var all_raw_data = [];
	var all_raw_rs485 = [];
	var all_raw_flow = [];
	var all_raw_flow_tot = [];
	var push_datas = [];

	// async
	async.parallel({
		async_control_sensor : function(callback) {
			pool.getConnection(function(err, connection) {
				if (err) {
					console.log(err);
				}
				connection.query('SELECT * FROM app_control_sensor ORDER BY type_inp')
				.on('error', function(err) {
					console.log(err);
				})
				.on('result', function(res) {
					all_control_sensor.push(res);
				})
				.on('end', function() {
					data.control_sensor = all_control_sensor;
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
			
			for (var i = 0; i < data.control_sensor.length;  i++) {
				var sensor_id = data.control_sensor[i].id;
				var sensor_name = data.control_sensor[i].name_profile;
				var sensor_source =	data.control_sensor[i].source_inp;
				var sensor_type = data.control_sensor[i].type_inp;
				var sensor_chanel = data.control_sensor[i].chanel;
				var sensor_isAnalog = data.control_sensor[i].type_sensor_analog;
				var sensor_rangeMin = data.control_sensor[i].range_min;
				var sensor_rangeMax = data.control_sensor[i].range_max;
				var sensor_unit = data.control_sensor[i].unit_sensor;
				var sensor_linearitas = data.control_sensor[i].linearitas;
				var sensor_decimal = data.control_sensor[i].decimal_places;
				var sensor_coefficient = data.control_sensor[i].coef_val;
				var sensor_coefficientUnit = data.control_sensor[i].coef_unit;
				
				var sensor_lowMA = data.control_sensor[i].low_ma;
				var sensor_highMA = data.control_sensor[i].high_ma;
				var sensor_lowValue = data.control_sensor[i].low_value;
				var sensor_highValue = data.control_sensor[i].high_value;
				
				var sensor_offset1 = data.control_sensor[i].offset1;
				var sensor_offset2 = data.control_sensor[i].offset2;
				var sensor_alarmL = data.control_sensor[i].alarm_L;
				var sensor_alarmH = data.control_sensor[i].alarm_H;
				var sensor_alarmLE = data.control_sensor[i].alarm_LE;
				var sensor_alarmHE = data.control_sensor[i].alarm_HE;
				var sensor_alarmLL = data.control_sensor[i].alarm_LL;
				var sensor_alarmHH = data.control_sensor[i].alarm_HH;
				var sensor_alarmLLE = data.control_sensor[i].alarm_LLE;
				var sensor_alarmHHE = data.control_sensor[i].alarm_HHE;
				var sensor_outL = data.control_sensor[i].out_L;
				var sensor_outH = data.control_sensor[i].out_H;
				var sensor_outLL = data.control_sensor[i].low_value;
				var sensor_outHH = data.control_sensor[i].out_HH;

				if (sensor_source == 1) {
					var field_raw_data = 's'+sensor_chanel;
					var sensor_valueRaw = data.raw_data[0][field_raw_data];
					var sensor_dateRecorded = data.raw_data[0]['date_record'];
					var sensor_value = calcRawData(sensor_valueRaw, sensor_lowMA, sensor_highMA, sensor_lowValue, sensor_highValue, sensor_offset1, sensor_coefficient);
					data_process['analog_'+sensor_chanel] = [sensor_name, array_type[sensor_type]];
				} else if (sensor_source == 2) {
					var field_raw_rs485 = 's'+sensor_chanel;
					var sensor_valueRaw = data.raw_rs485[0][field_raw_rs485];
					var sensor_dateRecorded = data.raw_data[0]['date_record'];
					var sensor_value = calcRawRs485(sensor_valueRaw, sensor_coefficient, sensor_offset1, sensor_offset2);
					data_rs485[sensor_chanel] = [sensor_name, array_type[sensor_type]];
				} else {
					if (sensor_type == 3) {
						var field_raw_flow_tot = 's'+sensor_chanel;
						var sensor_valueRaw = data.raw_flow[0][field_raw_flow_tot];
						var sensor_dateRecorded = data.raw_data[0]['date_record'];
						var sensor_value = calcRawFlowTot(sensor_valueRaw, sensor_coefficient, sensor_offset1);
					} else {
						var field_raw_flow = 's'+sensor_chanel;
						var sensor_valueRaw = data.raw_flow[0][field_raw_flow];
						var sensor_dateRecorded = data.raw_data[0]['date_record'];
						var sensor_value = calcRawFlow(sensor_valueRaw, sensor_coefficient, sensor_offset1);
						data_process['pulse_'+sensor_chanel] = [sensor_name, array_type[sensor_type]];
					}
				}

				var push_data = {};

				push_data.sensor_id = sensor_id;
				push_data.sensor_name = sensor_name;
				push_data.sensor_value = sensor_value.toFixed(sensor_decimal);
				push_data.sensor_dateRecorded = localeDateTime(sensor_dateRecorded);
				push_data.sensor_coefficientUnit = sensor_coefficientUnit;
				push_data.sensor_type = sensor_type;

				var push_dataKeyId = {};

				push_dataKeyId.sensor_id = sensor_id;
				push_dataKeyId.sensor_name = sensor_name;
				push_dataKeyId.sensor_value = sensor_value.toFixed(sensor_decimal);
				push_dataKeyId.sensor_dateRecorded = localeDateTime(sensor_dateRecorded);
				push_dataKeyId.sensor_coefficientUnit = sensor_coefficientUnit;
				push_dataKeyId.sensor_type = sensor_type;
				data_process[sensor_id] = push_dataKeyId;

				data_process[sensor_name] = sensor_value.toFixed(sensor_decimal);

				data_process.data_all_rs485 = data_rs485;

				push_datas.push(push_data);
			}

			// RAW DATA BEFORE CALC / ORIGINAL FROM SENSORS
			data_process.raw_data = all_raw_data[0];
			data_process.raw_rs485 = all_raw_rs485[0];
			data_process.raw_flow = all_raw_flow[0];
			data_process.raw_flow_tot = all_raw_flow_tot[0];

			data_process.push = push_datas;

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
			console.log(connectionsArray);
			console.log('lorem');
		}
	});

	console.log('A new socket is connected !');
	connectionsArray.push(socket);
});

app.listen(8000);
console.log('Please use your browser to navigate to http://localhost:8000');