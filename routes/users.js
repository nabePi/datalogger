var express = require('express');
var passport = require('passport');
var bcrypt = require('bcrypt-nodejs');
var router = express.Router();
var async = require('async');
var mysql = require('mysql');
var dbconfig = require('../config/database');
var connection =  mysql.createConnection(dbconfig.connection);
var connectionReading = mysql.createConnection(dbconfig.connectionReading);

router.get('/', function(req, res, next) {
	var returnValue = {};
	connection.query("SELECT users.id, users.username, users_group.name FROM users INNER JOIN users_group ON users.id_group = users_group.id", function(err, rows, field) {
		if (err) {
			console.log(err);
		}

		if (rows) {
			returnValue.results = rows;
			console.log(rows);

			connection.query("SELECT * FROM users_group", function(err, rows, field) {
				if (err) {
					console.log(err);
				}

				if (rows) {
					returnValue.groups = rows;
					console.log(rows);
					res.render('users', {'results' : returnValue.results, 'groups': returnValue.groups});
				}
			});

		}
	});
});

router.get('/view/:id', function(req, res, next) {
	var id = req.params.id;
	connection.query("SELECT users.id, users.username, users_group.name FROM users INNER JOIN users_group ON users.id_group = users_group.id AND users.id = ?", [id], function(err, rows, field) {
		if (err) {
			console.log(err);
		}

		if (rows) {
			console.log(rows);
			res.render('users_view', {'result' : rows});
		}
	});
});

router.get('/group/view/:id', function(req, res, next) {
	var id = req.params.id;
	connection.query("SELECT * FROM users_group WHERE id = ?", [id], function(err, rows, field) {
		if (err) {
			console.log(err);
		}

		if (rows) {
			console.log(rows);
			res.render('groups_view', {'result' : rows});
		}
	});
});

router.get('/form/:id', function(req, res, next) {
	var id = req.params.id;
	var returnValue = {};
	connection.query("SELECT users.id, users.username, users.id_group, users_group.name FROM users INNER JOIN users_group ON users.id_group = users_group.id AND users.id = ?", [id], function(err, rows, field) {
		if (err) {
			console.log(err);
		}

		if (rows) {
			returnValue.results = rows;
			console.log(rows);

			connection.query("SELECT * FROM users_group", function(err, rows, field) {
				if (err) {
					console.log(err);
				}

				if (rows) {
					returnValue.groups = rows;
					console.log(rows);
					res.render('users_form', {'result' : returnValue.results, 'groups': returnValue.groups});
				}
			});

		}
	});
});


router.get('/group/form/:id', function(req, res, next) {
	var id = req.params.id;
	connection.query("SELECT * FROM users_group WHERE id = ?", [id], function(err, rows, field) {
		if (err) {
			console.log(err);
		}

		if (rows) {
			res.render('groups_form', {'result' : rows});
		}
	});
});

router.put('/group/:id', function(req, res, next) {
	var valueUpdate ={};
	
	valueUpdate.name = req.body.name_group;
	valueUpdate.description = req.body.description;

	var querySql = 'update users_group SET ? where id = '+req.params.id;

	connection.query(querySql, valueUpdate, function (error, results, fields) {
  		if (error) throw error;
  		if (results.affectedRows) {
  			res.redirect('/users');
  		}
	});

});

router.put('/:id', function(req, res, next) {
	var valueUpdate ={};
	valueUpdate.username = req.body.username;
	if (req.body.password.length > 1) {
		valueUpdate.password = bcrypt.hashSync(req.body.password, null, null);	
	}
	valueUpdate.id_group = req.body.group;

	var querySql = 'update users SET ? where id = '+req.params.id;

	connection.query(querySql, valueUpdate, function (error, results, fields) {
  		if (error) throw error;
  		if (results.affectedRows) {
  			res.redirect('/users');
  		}
	});

});

router.get('/form', function(req, res, next) {
	connection.query("SELECT * FROM users_group", function(err, rows, field) {
		if (err) {
			console.log(err);
		}

		if (rows) {
			res.render('users_form', {'groups' : rows, 'result' : null});
			console.log(rows);
		}
	});
});

router.get('/group/form', function(req, res, next) {
	res.render('groups_form', {'result' : null});
});

router.post('/group', function(req, res, next) {
	var valueInsert ={};
	valueInsert.name = req.body.name_group;
	valueInsert.description = req.body.description;

	console.log(valueInsert);

	connection.query('INSERT INTO users_group SET ?', valueInsert, function (error, results, fields) {
  		if (error) throw error;
  		if (results.affectedRows) {
  			res.redirect('/users');
  		}
	});
});

router.post('/', function(req, res, next) {
	var valueInsert ={};
	valueInsert.username = req.body.username;
	valueInsert.password = bcrypt.hashSync(req.body.password, null, null);
	valueInsert.id_group = req.body.group;

	connection.query('INSERT INTO users SET ?', valueInsert, function (error, results, fields) {
  		if (error) throw error;
  		if (results.affectedRows) {
  			res.redirect('/users');
  		}
	});
});

router.delete('/delete', function(req, res, next) {
	connection.query("DELETE FROM users WHERE id = ?", [req.body.id], function(err, result) {
		if (err) {
			console.log(err);
		}
		if (result.affectedRows) {
  			res.send(true);
  		}
		
	});
});

router.delete('/group/delete', function(req, res, next) {
	connection.query("DELETE FROM users_group WHERE id = ?", [req.body.id], function(err, result) {
		if (err) {
			console.log(err);
		}
		if (result.affectedRows) {
  			res.send(true);
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
