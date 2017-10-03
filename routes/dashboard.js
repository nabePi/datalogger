var express = require('express');
var router = express.Router();

var mysql = require('mysql');
var dbconfig = require('../config/database');
var connection =  mysql.createConnection(dbconfig.connection);
var connectionReading = mysql.createConnection(dbconfig.connectionReading);

router.get('/group', function(req, res, next){
	connection.query("SELECT * FROM groups", function(err, rows){
		if(err) {
			console.log(err);
		}
		if (rows) {
			res.render('dashboard_group', {'results':rows});
		}
	});
});

router.get('/setupold', isAuth, function(req, res, next){
	var id = req.user.id;
	connection.query("SELECT dashboard.id, dashboard.users_id, dashboard._group, dashboard._sensor, dashboard._color, groups.`name` FROM dashboard INNER JOIN groups ON dashboard._group = groups.id AND dashboard.users_id = ?", [id], function(err, rows){
		if(err) {
			console.log(err);
		}
		if (rows) {
			res.render('dashboard_setup', {'results':rows});
		}
	});	
});

router.get('/setupold/:id', function(req, res, next) {
	var id = req.params.id;
	connection.query("SELECT * FROM dashboard WHERE id = ?", [id], function(err, rows, field) {
		if (err) {
			console.log(err);
		}
		if (rows) {
			res.send(rows);
		}
	});
});

router.put('/setupold/:id', function(req, res, next){
	var dataInput = {};
	dataInput._decimal = req.body.setDecimal;
	dataInput._settozero = req.body.setToZero;

	var sql = "UPDATE dashboard SET ? WHERE id = " + req.params.id;
	connection.query(sql, dataInput, function(err, result, fields){
		if(err) throw err;
		if(result.affectedRows){
			res.redirect('/dashboard/setupold');
			console.log("Success");
		}
	});
});

router.get('/setup', isAuth, function(req, res, next){
	var id = req.user.id;
	// connection.query("SELECT dashboard.id, dashboard.users_id, dashboard._group, dashboard._sensor, dashboard._color, groups.`name` FROM dashboard INNER JOIN groups ON dashboard._group = groups.id AND dashboard.users_id = ?", [id], function(err, rows){
	connection.query("SELECT * FROM groups ", function(err, rows){
		if(err) {
			console.log(err);
		}
		if (rows) {
			// OLD dashboard setup
			// res.render('dashboard_setup', {'results':rows});

			connection.query("SELECT * FROM sensors_raw", function(errx, rowsx){
				if(errx) {
					console.log(errx);
				}

				if (rowsx) {
					connection.query("SELECT * FROM sensors_calc", function(erry, rowsy){
						if (erry) {
							console.log(erry)
						}

						if (rowsy) {
							res.render('dashboard_setupv2' , {'groups' : rows, 'sensors_raw' : rowsx, 'sensors_calc' : rowsy});
						}
					});
				}
			});

			// dashboard setup v2 drag&drop
			// res.render('dashboard_setupv2', {'results':rows});
		}
	});
});

router.delete('/setup/delete', function(req, res, next) {
	connection.query("DELETE FROM dashboard WHERE id = ?", [req.body.id], function(err, result) {
		if (err) {
			console.log(err);
		}
		if (result.affectedRows) {
  			res.send(true);
  		}
		
	});
});

router.delete('/group/delete', function(req, res, next) {
	connection.query("DELETE FROM groups WHERE id = ?", [req.body.id], function(error, result) {
		if (error) {
			console.log(error);
		}
		if (result.affectedRows) {
  			connection.query("DELETE FROM dashboard WHERE _group = ?", [req.body.id], function(err, rslt) {
				if (err) {
					console.log(err);
				}
				if (rslt) {
					res.send(true);
		  		}	
			});
  		}
		
	});
});

router.get('/group/empty/:id', function(req, res, next) {
	connection.query("DELETE FROM dashboard WHERE _group = ?", [req.params.id], function(err, rslt) {
		if (err) {
			console.log(err);
		}
		if (rslt) {
			res.send(true);
  		}	
	});
});

router.get('/group/form/:id', function(req, res, next) {
	var id = req.params.id;
	connection.query("SELECT * FROM groups WHERE id = ?", [id], function(err, rows, field) {
		if (err) {
			console.log(err);
		}

		if (rows) {
			res.render('dashboard_group_form', {'result' : rows});
		}
	});
});

router.put('/group/:id', function(req, res, next) {
	var valueUpdate ={};
	
	valueUpdate.name = req.body.name_group;
	valueUpdate.description = req.body.description;

	var querySql = 'update groups SET ? where id = '+req.params.id;

	connection.query(querySql, valueUpdate, function (error, results, fields) {
  		if (error) throw error;
  		if (results.affectedRows) {
  			res.redirect('/dashboard/group');
  		}
	});

});

router.get('/group/form', function(req, res, next) {
	res.render('dashboard_group_form', {'result' : null});
});

router.post('/group', function(req, res, next) {
	var valueInsert ={};
	valueInsert.name = req.body.name_group;
	valueInsert.description = req.body.description;

	connection.query('INSERT INTO groups SET ?', valueInsert, function (error, results, fields) {
  		if (error) throw error;
  		if (results.affectedRows) {
  			res.redirect('/dashboard/group');
  		}
	});
});

router.post('/group/v2', function(req, res, next) {
	console.log(req.body);
	var groupV = req.body.group;
	var foo_array = JSON.parse(req.body.foo_array);
	console.log(foo_array);

	var multipleArray = [];

	for (var i = 0; i < foo_array.length; i++) {
		
		var valueInsert =[];
		valueInsert = [foo_array[i][0], groupV, 2, foo_array[i][1]];
		
		// console.log(valueInsert);

		multipleArray.push(valueInsert);
	}
	
	console.log(multipleArray);

	var sql = "INSERT INTO dashboard (_sensor, _group, users_id, is_calc) VALUES ?";

	connection.query("DELETE FROM dashboard WHERE _group = ?", groupV, function(err, rslt) {
		if (err) {
			console.log(err);
		}
		if (rslt) {
  			connection.query(sql, [multipleArray], function (error, results, fields) {
		  		if (error) throw error;
		  		if (results.affectedRows) {
		  			res.send(true);
		  		}
			});
  		}	
	});
})

router.get('/getsensors/:id', isAuth, function(req, res, next) {
	var id = req.params.id;
	connection.query("SELECT * FROM dashboard WHERE _group = ?", [id], function(error, rows) {
		if (error){
			console.log(error);
		}

		if (rows) {
			console.log(rows);
			res.send(rows);
		}
	})
});

router.get('/groupid/:id', isAuth, function(req, res, next) {
	var id = req.user.id;
	var groupId = req.params.id;
	var arrayGroup = [];
	
	
	connection.query("SELECT dashboard.id, dashboard.users_id, dashboard._group, dashboard._sensor, dashboard.is_calc, dashboard._decimal, dashboard._settozero, dashboard._color, groups.id, groups.`name` FROM dashboard INNER JOIN groups ON dashboard._group = groups.id AND dashboard.users_id = ? GROUP BY dashboard._group", [id], function(err, rows){
		if(err) {
			console.log(err);
		}

		if(rows){
			var counterPause = 1;
			var arrayGroupValue = {};
			for (var i =0;  i < rows.length; i++) {
				 
				connection.query("SELECT dashboard.id, dashboard.users_id, dashboard._group, dashboard._sensor, dashboard.is_calc, dashboard._decimal, dashboard._settozero, dashboard._color, groups.id, groups.`name` FROM dashboard INNER JOIN groups ON dashboard._group = groups.id AND dashboard._group = ? AND dashboard.users_id = ?", [rows[i]._group, id], function(errFoo, rowsFoo){
					
					if(errFoo) {
						console.log(errFoo);
					}

					if(rowsFoo){
						arrayGroupValue[rowsFoo[0]._group] = rowsFoo;
						// console.log(keyGroup);
						counterPause = counterPause + 1;

						if (counterPause > rows.length) {
							var tempVar = arrayGroupValue;
							if (arrayGroupValue.length == rows.length) {
								console.log('send');
							}
							res.render('dashboardv2', {'arrayGV' : arrayGroupValue, 'groupSensor' : rows, 'countArrayGV' : arrayGroupValue.length, 'groupId' : groupId});

						}	
					}
				});
			}	
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