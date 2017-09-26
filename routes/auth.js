var express = require('express');
var passport = require('passport');
var router = express.Router();

router.get('/signin', function(req, res, next) {
	res.render('signin', { message: req.flash('msgSignin') });
});

router.post('/signin', 
	passport.authenticate('local-signin', {
			successRedirect : '/reader/v2',
			failureRedirect : '/auth/signin',
			failureFlash : true
		}),
	function(req, res, next) {
		// if (req.body.remember) {
		// 	req.sesssion.cookie.maxAge = 1000 * 60 * 3;
		// } else {
		// 	req.sesssion.cookie.expires = false;
		// }
		res.redirect('/');
	}
);

router.get('/signout', function(req, res) {
	req.logout();
	res.redirect('/auth/signin');
});

module.exports = router