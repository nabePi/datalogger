var express = require('express');
var router = express.Router();

var mysql = require('mysql');
var dbconfig = require('../config/database');
var connection =  mysql.createConnection(dbconfig.connection);
var connectionReading = mysql.createConnection(dbconfig.connectionReading);

router.get('/', function(req, res, next) {
	connectionReading.query("SELECT * FROM app_control_sensor", function(err, rows, field) {
		if (err) {
			console.log(err);
		}

		if (rows) {
			res.render('sensors', {'results' : rows});
		}
	});
});

router.get('/view/:id', function(req, res, next) {
	var id = req.params.id;
	connectionReading.query("SELECT * FROM app_control_sensor WHERE id = ?", [id], function(err, rows, field) {
		if (err) {
			console.log(err);
		}

		if (rows) {
			console.log(rows);
			res.render('sensors_view', {'result' : rows});
		}
	});
});

router.delete('/delete', function(req, res, next) {
	connectionReading.query("DELETE FROM app_control_sensor WHERE id = ?", [req.body.id], function(err, result) {
		if (err) {
			console.log(err);
		}
		if (result.affectedRows) {
  			res.send(true);
  		}
		
	});
});

router.get('/form', function(req, res, next) {
	res.render('sensors_form', {'result' : null});
});

router.get('/form/:id', function(req, res, next) {
	var id = req.params.id;
	connectionReading.query("SELECT * FROM app_control_sensor WHERE id = ?", [id], function(err, rows) {
		if (err) {
			console.log(err);
		}
		console.log(rows);
		res.render('sensors_form', {'result' : rows});
	});
});

router.post('/', function(req, res, next) {
	
	var valueSensor = {};

	valueSensor.name_profile = req.body.name;
	valueSensor.source_inp = req.body.source;
	valueSensor.type_inp = req.body.type;
	if (valueSensor.source_inp == 1) {
		valueSensor.type_sensor_analog = 1;
	} else {
		valueSensor.type_sensor_analog = 0;
	}
	valueSensor.chanel = req.body.chanel;
	valueSensor.unit_sensor = req.body.unit;
	valueSensor.range_min = req.body.low;
	valueSensor.range_max = req.body.high;
	valueSensor.decimal_places = req.body.decimal;
	valueSensor.coef_val = req.body.coefficient;
	valueSensor.coef_unit = req.body.coefficientUnit;
	valueSensor.offset1 = req.body.offset;
	valueSensor.low_ma = req.body.lowMA;
	valueSensor.high_ma = req.body.highMA;
	valueSensor.low_value = req.body.lowValue;
	valueSensor.high_value = req.body.highValue;
	
	var fooVar1 = Math.abs(parseInt(req.body.highValue) - parseInt(req.body.lowValue));
	if (fooVar1 > 1) {
		var linearitasVal = Math.abs(((parseInt(req.body.highMA) - parseInt(req.body.lowMA)) / fooVar1))
	} else {
		var linearitasVal = 0;
	}

	valueSensor.linearitas = linearitasVal;

	connectionReading.query('INSERT INTO app_control_sensor SET ?', valueSensor, function (error, results, fields) {
  		if (error) throw error;
  		if (results.affectedRows) {
  			res.redirect('/sensors');
  		}
	});
});

router.put('/:id', function(req, res, next) {
	
	var id = req.params.id;

	var valueSensor = {};

	valueSensor.name_profile = req.body.name;
	valueSensor.source_inp = req.body.source;
	valueSensor.type_inp = req.body.type;
	if (valueSensor.source_inp == 1) {
		valueSensor.type_sensor_analog = 1;
	} else {
		valueSensor.type_sensor_analog = 0;
	}
	valueSensor.chanel = req.body.chanel;
	valueSensor.unit_sensor = req.body.unit;
	valueSensor.range_min = req.body.low;
	valueSensor.range_max = req.body.high;
	valueSensor.decimal_places = req.body.decimal;
	valueSensor.coef_val = req.body.coefficient;
	valueSensor.coef_unit = req.body.coefficientUnit;
	valueSensor.offset1 = req.body.offset;
	valueSensor.low_ma = req.body.lowMA;
	valueSensor.high_ma = req.body.highMA;
	valueSensor.low_value = req.body.lowValue;
	valueSensor.high_value = req.body.highValue;
	
	var fooVar1 = Math.abs(parseInt(req.body.highValue) - parseInt(req.body.lowValue));
	if (fooVar1 > 1) {
		var linearitasVal = Math.abs(((parseInt(req.body.highMA) - parseInt(req.body.lowMA)) / fooVar1))
	} else {
		var linearitasVal = 0;
	}

	valueSensor.linearitas = linearitasVal;

	var querySql = 'update app_control_sensor SET ? where id = '+req.params.id;

	connectionReading.query(querySql, valueSensor, function (error, results, fields) {
  		if (error) throw error;
  		if (results.affectedRows) {
  			res.redirect('/sensors');
  		}
	});

});

function isAuth(req, res, next){
	if (req.isAuthenticated()) {
		return next();
	}
	res.redirect('/');
}

module.exports = router;
