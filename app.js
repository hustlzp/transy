/*
 * App File
 */

var express = require('express'),
    routes = require('./routes'),
    http = require('http'),
    path = require('path'),
    config = require('./config'),
    mongoose = require('mongoose');

app = express();

// db
option = {
    server: {
        keepAlive: 1
    },
    replset: {
        keepAlive: 1
    }
};
mongoose.connect('mongodb://localhost:27017/transy', option);

app.set('port', process.env.PORT || 3000);
app.set('ip', '127.0.0.1');
app.set('views', __dirname + '/views');
app.set('view engine', 'jade');
app.use(express.logger('dev'));
app.use(express.cookieParser());
app.use(express.bodyParser());
app.use(express.methodOverride());
app.use(express["static"](path.join(__dirname, 'static')));

// Inject vars to template
app.use(function (req, res, next) {
    res.locals.cookies = req.cookies;
    res.locals.config = config;
    return next();
});

if ('development' === app.get('env')) {
    app.use(express.errorHandler());
}

routes(app);

http.createServer(app).listen(app.get('port'), app.get('ip'), 511, function () {
    return console.log('Express server listening on ' + app.get('ip') + ':' + app.get('port'));
});