var LocalStrategy = require('passport-local').Strategy;
var mysql = require('mysql');
var dbconfig = require('./database');
var connection = mysql.createConnection(dbconfig.connection);

var flash = require('express-flash');
var bcrypt = require('bcrypt-nodejs');

connection.query('USE ' + dbconfig.connection.database, function(err, rows){
	if (err) {
		console.log(err);
	}
});

module.exports = function(passport) {
	passport.serializeUser(function(user, done) {
		done(null, user.id);
	});

	passport.deserializeUser(function(id, done) {
		connection.query("SELECT * FROM users WHERE id = ?",[id],function(err, rows) {
			done(err, rows[0]);
		})
	});

	passport.use(
		'local-signin',
		new LocalStrategy({
			usernameField : 'username',
			passwordField : 'password',
			passReqToCallback : true
		},
		function(req, username, password, done) {
			connection.query("SELECT * FROM users WHERE username = ?", [username], function(err, rows){
				if (err) {
					return done(err);
				}
				if (!rows.length) {
					return done(null, false, req.flash('msgSignin', 'No user found.'));
				}
				if (!bcrypt.compareSync(password, rows[0].password)) {
					return done(null, false, req.flash('msgSignin', 'Oops! Wrong password.'));
				}
				return done(null, rows[0]);
			});
		})
	);

	passport.use(
        'local-signup',
        new LocalStrategy({
            usernameField : 'username',
            passwordField : 'password',
            passReqToCallback : true
        },
        function(req, username, password, done) {
        	console.log(req.body.group);
        	console.log(username);
            connection.query("SELECT * FROM users WHERE username = ?",[username], function(err, rows) {
                console.log(rows.length);
                if (err)
                	console.log('error')
                    //return done(err);
                if (rows.length > 0) {
                	console.log('mbalik');
                    //return done(null, false, req.flash('msgSignup', 'That username is already taken.'));
                } else {
                	console.log('testing');
                    var newUserMysql = {
                        username: username,
                        password: bcrypt.hashSync(password, null, null),
                        id_group: req.body.group
                    };
                    console.log(newUserMysql);

                    var insertQuery = "INSERT INTO users ( username, password, id_group ) values (?,?,?)";

                    connection.query(insertQuery,[newUserMysql.username, newUserMysql.password, newUserMysql.id_group],function(err, rows) {

                        return done(null, newUserMysql);
                    });
                }
            });
        })
    );
}