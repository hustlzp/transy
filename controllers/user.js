/*
 * User Controller
 */

var url = require('url'),
    EventProxy = require('eventproxy'),
    User = require('../models/user'),
    Article = require('../models/article'),
    mongoose = require('mongoose'),
    ObjectId = mongoose.Types.ObjectId;

exports.showSetting = function (req, res) {
    User.findById(req.cookies.user.id, function (err, u) {
        res.render('user/setting', {u: u});
    });
};

exports.setting = function (req, res) {
    User.findById(req.cookies.user.id, function (err, u) {
        res.render('user/setting', {u: u});
    });
};