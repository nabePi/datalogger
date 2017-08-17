var express = require('express');
var router = express.Router();

var mysql = require('mysql');
var dbconfig = require('../config/database');
var connection =  mysql.createConnection(dbconfig.connection);
var connectionReading = mysql.createConnection(dbconfig.connectionReading);



router.get('/chanel', function(req, res, next) {
	var params = req.query.params;
	var type = req.query.type;
	var element = '';
	if (params == 1) {
		connectionReading.query("SELECT * FROM app_raw_data", function(err, rows, field) {
			var lengthCore = field.length - 3;
			for (var i = 1; i <= lengthCore; i++) {
				element += '<option value="'+i+'">Chanel '+i+'</option>';
			}
			res.send(element);
		});
	} else if (params == 2) {
		connectionReading.query("SELECT * FROM app_raw_rs485", function(err, rows, field) {
			var lengthCore = field.length - 2;
			for (var i = 1; i <= lengthCore; i++) {
				element += '<option value="'+i+'">Chanel '+i+'</option>';
			}
			res.send(element);
		});
	} else if (params == 3) {
		if (type == 3) {
			connectionReading.query("SELECT * FROM app_raw_flow_tot", function(err, rows, field) {
				var lengthCore = field.length - 3;
				for (var i = 1; i <= lengthCore; i++) {
					element += '<option value="'+i+'">Chanel '+i+'</option>';
				}
				res.send(element);
			});
		} else {
			connectionReading.query("SELECT * FROM app_raw_flow", function(err, rows, field) {
				var lengthCore = field.length - 3;
				for (var i = 1; i <= lengthCore; i++) {
					element += '<option value="'+i+'">Chanel '+i+'</option>';
				}
				res.send(element);
			});
		}
	}
});

router.post('/saveDashboard', function(req, res, next){
	console.log(req.body);
	var valueInsert ={};
	valueInsert._sensor = req.body.sensor;
	valueInsert._group = req.body.group;
	valueInsert.users_id = req.body.users_id;

	console.log(valueInsert);

	connection.query('INSERT INTO dashboard SET ?', valueInsert, function (error, results, fields) {
  		if (error) throw error;
  		if (results.affectedRows) {
  			res.send(true);
  		}
	});
});

router.get('/unit', function(req, res, next) {
	var type = req.query.type;
	var element = '';
	if (type == 0) {
		connection.query("SELECT * FROM unit_level", function(err, rows, field) {
			for (var i = 0; i < rows.length; i++) {
				element += '<option value="'+rows[i].sumber+'">'+rows[i].sumber+'</option>';
			}
			res.send(element);
		});
	} else if (type == 1) {
		connection.query("SELECT * FROM unit_pressure", function(err, rows, field) {
			for (var i = 0; i < rows.length; i++) {
				element += '<option value="'+rows[i].sumber+'">'+rows[i].sumber+'</option>';
			}
			res.send(element);
		});
	} else if (type == 2) {
		connection.query("SELECT * FROM unit_temperature", function(err, rows, field) {
			for (var i = 0; i < rows.length; i++) {
				element += '<option value="'+rows[i].sumber+'">'+rows[i].sumber+'</option>';
			}
			res.send(element);
		});
	} else if (type == 3) {
		connection.query("SELECT * FROM unit_flow", function(err, rows, field) {
			for (var i = 0; i < rows.length; i++) {
				element += '<option value="'+rows[i].sumber+'">'+rows[i].sumber+'</option>';
			}
			res.send(element);
		});
	} else if (type == 4) {
		connection.query("SELECT * FROM unit_h2s", function(err, rows, field) {
			for (var i = 0; i < rows.length; i++) {
				element += '<option value="'+rows[i].sumber+'">'+rows[i].sumber+'</option>';
			}
			res.send(element);
		});
	} else if (type == 5) {
		connection.query("SELECT * FROM unit_rpm", function(err, rows, field) {
			for (var i = 0; i < rows.length; i++) {
				element += '<option value="'+rows[i].sumber+'">'+rows[i].sumber+'</option>';
			}
			res.send(element);
		});
	} else if (type == 6) {
		connection.query("SELECT * FROM unit_gas", function(err, rows, field) {
			for (var i = 0; i < rows.length; i++) {
				element += '<option value="'+rows[i].sumber+'">'+rows[i].sumber+'</option>';
			}
			res.send(element);
		});
	}
});


function isAuth(req, res, next){
	if (req.isAuthenticated()) {
		return next();
	}
	res.redirect('/');
}

module.exports = router;
