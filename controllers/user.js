/**
 * User Controller
 */

var url = require('url'),
    EventProxy = require('eventproxy'),
    User = require('../models/user'),
    Article = require('../models/article'),
    mongoose = require('mongoose'),
    ObjectId = mongoose.Types.ObjectId;

exports.showSettings = function (req, res) {
    User.findById(req.cookies.user.id, function (err, u) {
        res.render('user/settings', {u: u});
    });
};

exports.settings = function (req, res) {
    if (req.form.isValid) {
        User.findById(req.cookies.user.id, function (err, u) {
            res.render('user/settings', {u: u});
        });
    } else {
        res.render('user/settings', {form: req.form});
    }
};