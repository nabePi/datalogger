// var fs = require('fs');
var express = require('express');
var router = express.Router();

var mysql = require('mysql');
var dbconfig = require('../config/database');
var connection =  mysql.createConnection(dbconfig.connection);
var connectionReading = mysql.createConnection(dbconfig.connectionReading);

router.get('/' , function(req, res, next) {
	connectionReading.query("SELECT name_profile FROM app_control_sensor", function(err, rows){
		if(err) {
			console.log(err);
		}

		if(rows){
			res.render('logger', {'result' : rows});	
		}
	});	
});

router.get('/stream' , function(req, res, next) {
	connectionReading.query("SELECT name_profile FROM app_control_sensor", function(err, rows){
		if(err) {
			console.log(err);
		}

		if(rows){
			res.render('stream', {'result' : rows});	
		}
	});	
});

// function isAuth(req, res, next){
// 	if (req.isAuthenticated()) {
// 		return next();
// 	}
// 	res.redirect('/');
// }

module.exports = router;
