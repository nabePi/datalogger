var express = require('express');
var passport = require('passport');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
	if (!req.isAuthenticated()) {
		res.redirect('/auth/signin');
	} else {
  		res.render('index', { title: 'Express with ejs' });
  	}
});

module.exports = router;
