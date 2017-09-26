// var fs = require('fs');
var express = require('express');
var router = express.Router();

var mysql = require('mysql');
var dbconfig = require('../config/database');
var connection =  mysql.createConnection(dbconfig.connection);
var connectionReading = mysql.createConnection(dbconfig.connectionReading);

router.get('/', isAuth , function(req, res, next) {
	var users_id = req.user.id;
	connection.query("SELECT * FROM groups", function(err, rows, field) {
		if (err) {
			console.log(err);
		}

		if (rows) {
			res.render('reader', {'groups': rows, 'users_id': users_id});
		}
	});
});

router.get('/v2', isAuth , function(req, res, next) {
	var users_id = req.user.id;
	connection.query("SELECT * FROM groups", function(err, rows, field) {
		if (err) {
			console.log(err);
		}

		if (rows) {
			res.render('readerv2', {'groups': rows, 'users_id': users_id});
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
