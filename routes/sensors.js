var express = require('express');
var router = express.Router();

var mysql = require('mysql');
var dbconfig = require('../config/database');
var connection =  mysql.createConnection(dbconfig.connection);
var connectionReading = mysql.createConnection(dbconfig.connectionReading);

router.get('/', function(req, res, next) {
	res.render('sensorsv2');
});

// ============
// ANALOG ROUTE
// ============

router.post('/', function(req, res, next) {
	
	var valueSensor = {};

	valueSensor.name = req.body.name;
	valueSensor.source = req.body.source;
	valueSensor.chanel = req.body.chanel;
	valueSensor.type = req.body.type;
	
	valueSensor.low_ma = req.body.low_ma;
	valueSensor.high_ma = req.body.high_ma;
	valueSensor.value_min = req.body.value_min;
	valueSensor.value_max = req.body.value_max;

	valueSensor.unit = req.body.unit;

	valueSensor.low_ma_calibration = req.body.low_ma_calibration;
	valueSensor.high_ma_calibration = req.body.high_ma_calibration;
	valueSensor.value_min_calibration = req.body.value_min_calibration;
	valueSensor.value_max_calibration = req.body.value_max_calibration;

	valueSensor.offset = req.body.offset;
	
	var linearity = 0;
	var fooVar1 = Math.abs(parseInt(req.body.value_max) - parseInt(req.body.value_min));
	if (fooVar1 > 1) {
		var linearity = Math.abs(((parseInt(req.body.high_ma) - parseInt(req.body.low_ma)) / fooVar1))
	}
	valueSensor.linearity = linearity;

	console.log(valueSensor);

	connection.query('INSERT INTO sensors_raw SET ?', valueSensor, function (error, results, fields) {
  		if (error) throw error;
  		if (results.affectedRows) {
  			res.redirect('/sensors');
  		}
	});
});

router.put('/:id', function(req, res, next) {
	
	var valueSensor = {};

	valueSensor.name = req.body.name;
	valueSensor.source = req.body.source;
	// valueSensor.chanel = req.body.chanel;
	valueSensor.type = req.body.type;
	
	valueSensor.low_ma = req.body.low_ma;
	valueSensor.high_ma = req.body.high_ma;
	valueSensor.value_min = req.body.value_min;
	valueSensor.value_max = req.body.value_max;

	valueSensor.unit = req.body.unit;

	valueSensor.low_ma_calibration = req.body.low_ma_calibration;
	valueSensor.high_ma_calibration = req.body.high_ma_calibration;
	valueSensor.value_min_calibration = req.body.value_min_calibration;
	valueSensor.value_max_calibration = req.body.value_max_calibration;

	valueSensor.offset = req.body.offset;
	
	var linearity = 0;
	var fooVar1 = Math.abs(parseInt(req.body.value_max) - parseInt(req.body.value_min));
	if (fooVar1 > 1) {
		var linearity = Math.abs(((parseInt(req.body.high_ma) - parseInt(req.body.low_ma)) / fooVar1))
	}
	valueSensor.linearity = linearity;

	console.log(valueSensor);

	var querySql = 'UPDATE sensors_raw SET ? WHERE id = '+req.params.id;

	connection.query(querySql, valueSensor, function (error, results, fields) {
  		if (error) throw error;
  		if (results.affectedRows) {
  			res.redirect('/sensors');
  		}
	});
});

router.get('/analog/v2/edit/:id', function(req, res, next) {
	var id = req.params.id;
	console.log(id);
	connection.query("SELECT * FROM sensors_raw WHERE id = ?", [id], function(err, rows) {
		if (err) {
			console.log(err);
		}
		res.send(rows);
	});
});

router.get('/analog/v2/delete/:id', function(req, res, next) {
	console.log("DELETE ANALOG");
	connection.query("DELETE FROM sensors_raw WHERE id = ?", [req.params.id], function(err, result) {
		if (err) {
			console.log(err);
		}
		if (result.affectedRows) {
  			res.send(true);
  		}
		
	});
});

// =====================
// DIGITAL / PULSE ROUTE
// =====================

router.post('/pulse', function(req, res, next) {
	
	var valueSensor = {};

	valueSensor.name = req.body.namePulse;
	valueSensor.source = req.body.sourcePulse;
	valueSensor.chanel = req.body.chanelPulseHidden;
	valueSensor.type = req.body.typePulse;
	
	valueSensor.value_min = req.body.minValuePulse;
	valueSensor.value_max = req.body.maxValuePulse;

	valueSensor.unit = req.body.unitPulse;

	valueSensor.offset = req.body.offsetPulse;


	console.log(valueSensor);

	connection.query('INSERT INTO sensors_raw SET ?', valueSensor, function (error, results, fields) {
  		if (error) throw error;
  		if (results.affectedRows) {
  			res.redirect('/sensors');
  		}
	});
});




// ==========
// MATH ROUTE
// ==========

router.post('/calc', function(req, res, next){
	var valueSensorClac = {};
	valueSensorClac.name = req.body.nameMath;
	valueSensorClac.variable = '{'+req.body.variableMath+'}';
	valueSensorClac.variable_customize = '{'+req.body.variableCustomizeMath+'}';
	valueSensorClac.formula = req.body.formulaMath.replace(/,/g," ");

	console.log(valueSensorClac);

	connection.query('INSERT INTO sensors_calc SET ?', valueSensorClac, function (error, results, fields) {
  		if (error) throw error;
  		if (results.affectedRows) {
  			res.redirect('/sensors');
  		}
	});
})

router.get('/calc/:id', function(req, res, next) {
	var id = req.params.id;
	connection.query("SELECT * FROM sensors_calc WHERE id = ?", [id], function(err, rows) {
		if (err) {
			console.log(err);
		}
		console.log(rows);
		res.send(rows);
	});
});

router.get('/calc/delete/:id', function(req, res, next) {
	// console.log(req.params.id);
	// console.log(req.body);
	connection.query("DELETE FROM sensors_calc WHERE id = ?", [req.params.id], function(err, result) {
		if (err) {
			console.log(err);
		}
		if (result.affectedRows) {
  			res.send(true);
  		}
		
	});
});

router.put('/calc/:id', function(req, res, next){
	var id = req.params.id;
	
	var valueSensorClac = {};

	valueSensorClac.name = req.body.nameMath;
	valueSensorClac.variable = '{'+req.body.variableMath+'}';
	valueSensorClac.variable_customize = '{'+req.body.variableCustomizeMath+'}';
	valueSensorClac.formula = req.body.formulaMath.replace(/,/g," ");

	var querySql = 'UPDATE sensors_calc SET ? WHERE id = '+req.params.id;

	connection.query(querySql, valueSensorClac, function (error, results, fields) {
  		if (error) throw error;
  		if (results.affectedRows) {
  			res.redirect('/sensors');
  		}
	});
});


// ==============
// OLD SENSORS V1
// ==============

// router.put('/:id', function(req, res, next) {
	
// 	var id = req.params.id;

// 	var valueSensor = {};

// 	valueSensor.name_profile = req.body.name;
// 	valueSensor.source_inp = req.body.source;
// 	valueSensor.type_inp = req.body.type;
// 	if (valueSensor.source_inp == 1) {
// 		valueSensor.type_sensor_analog = 1;
// 	} else {
// 		valueSensor.type_sensor_analog = 0;
// 	}
// 	valueSensor.chanel = req.body.chanel;
// 	valueSensor.unit_sensor = req.body.unit;
// 	valueSensor.range_min = req.body.low;
// 	valueSensor.range_max = req.body.high;
// 	valueSensor.decimal_places = req.body.decimal;
// 	valueSensor.coef_val = req.body.coefficient;
// 	valueSensor.coef_unit = req.body.coefficientUnit;
// 	valueSensor.offset1 = req.body.offset;
// 	valueSensor.low_ma = req.body.lowMA;
// 	valueSensor.high_ma = req.body.highMA;
// 	valueSensor.low_value = req.body.lowValue;
// 	valueSensor.high_value = req.body.highValue;
	
// 	var fooVar1 = Math.abs(parseInt(req.body.highValue) - parseInt(req.body.lowValue));
// 	if (fooVar1 > 1) {
// 		var linearitasVal = Math.abs(((parseInt(req.body.highMA) - parseInt(req.body.lowMA)) / fooVar1))
// 	} else {
// 		var linearitasVal = 0;
// 	}

// 	valueSensor.linearitas = linearitasVal;

// 	var querySql = 'update app_control_sensor SET ? where id = '+req.params.id;

// 	connectionReading.query(querySql, valueSensor, function (error, results, fields) {
//   		if (error) throw error;
//   		if (results.affectedRows) {
//   			res.redirect('/sensors');
//   		}
// 	});

// });

// router.get('/view/:id', function(req, res, next) {
// 	var id = req.params.id;
// 	connectionReading.query("SELECT * FROM app_control_sensor WHERE id = ?", [id], function(err, rows, field) {
// 		if (err) {
// 			console.log(err);
// 		}

// 		if (rows) {
// 			res.render('sensors_view', {'result' : rows});
// 		}
// 	});
// });

// router.delete('/delete', function(req, res, next) {
// 	connectionReading.query("DELETE FROM app_control_sensor WHERE id = ?", [req.body.id], function(err, result) {
// 		if (err) {
// 			console.log(err);
// 		}
// 		if (result.affectedRows) {
//   			res.send(true);
//   		}
		
// 	});
// });

// router.get('/form', function(req, res, next) {
// 	res.render('sensors_form', {'result' : null});
// });

// router.get('/form/:id', function(req, res, next) {
// 	var id = req.params.id;
// 	connectionReading.query("SELECT * FROM app_control_sensor WHERE id = ?", [id], function(err, rows) {
// 		if (err) {
// 			console.log(err);
// 		}
// 		res.render('sensors_form', {'result' : rows});
// 	});
// });

function isAuth(req, res, next){
	if (req.isAuthenticated()) {
		return next();
	}
	res.redirect('/');
}

module.exports = router;
