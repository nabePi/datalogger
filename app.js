var express = require('express');
var session = require('express-session');
var flash = require('express-flash');
var path = require('path');
// var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var methodOverride = require('method-override')

var passport = require('passport');

require('./config/passport')(passport);

var index = require('./routes/index');
var users = require('./routes/users');
var sensors = require('./routes/sensors');
var reader = require('./routes/reader');
var auth = require('./routes/auth');
var xhr = require('./routes/xhr');
var logs = require('./routes/logger');
var appearance = require('./routes/appearance');
var dashboard = require('./routes/dashboard');

var app = express();

app.use(express.static('public'))
app.use(methodOverride('_method'));

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

// passport
app.use(session({
	secret: process.env.SESSION_SECRET || '<mysecret>',
	resave: true,
	saveUninitialized: true 
}));
app.use(passport.initialize());
app.use(passport.session());
app.use(flash());

app.use('/', index);
app.use('/users', users);
app.use('/sensors', sensors);
app.use('/reader', reader);
app.use('/auth', auth);
app.use('/xhr', xhr);
app.use('/logger', logs);
app.use('/appearance', appearance);
app.use('/dashboard', dashboard);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
