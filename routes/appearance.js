var express = require('express');
var router = express.Router();

router.get('/', function(req, res, next) {
	res.render('appearance');
});

function isAuth(req, res, next){
	if (req.isAuthenticated()) {
		return next();
	}
	res.redirect('/');
}

module.exports = router;
