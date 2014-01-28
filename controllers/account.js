/**
 * Sign Controller
 */

var User = require('../models/user'),
    mail = require('../service/mail'),
    mongoose = require('mongoose'),
    ObjectId = mongoose.Types.ObjectId;

exports.showSignup = function (req, res) {
    res.render('account/signup');
};

exports.signup = function (req, res, next) {
    if (req.form.isValid) {
        User.getByName(req.form.name, function (err, user) {
            if (user) {
                res.render('account/signup', { form: req.form });
            } else {
                User.getByEmail(req.form.email, function (err, user) {
                    var email, name, pwd, userId;
                    if (user) {
                        res.render('account/signup', { form: req.form });
                    } else {
                        userId = new ObjectId();
                        name = req.form.name;
                        email = req.form.email;
                        pwd = req.form.pwd;
                        User.add(userId, name, email, pwd, function (err) {
                            gene_cookie(res, userId, name, email);
                            res.redirect('/');
                        });
                    }
                });
            }
        });
    } else {
        res.render('account/signup', { form: req.form });
    }
};

exports.activeAccount = function (req, res) {
    res.send('active');
};

exports.showSignin = function (req, res) {
    res.render('account/signin');
};

exports.signin = function (req, res) {
    if (req.form.isValid) {
        User.getByEmail(req.form.email, function (err, user) {
            if (!user) {
                res.render('account/signin', { form: req.form });
            } else {
                User.getByEmailAndPwd(req.form.email, req.form.pwd, function (err, user) {
                    if (!user) {
                        res.render('account/signin', {
                            form: req.form
                        });
                    } else {
                        gene_cookie(res, user.id, user.name, user.email);
                        res.redirect('/');
                    }
                });
            }
        });
    } else {
        res.render('account/signin', { form: req.form });
    }
};

exports.signout = function (req, res) {
    res.clearCookie('user');
    res.redirect('/');
};

/*
 * Generate cookie of user name, id, email for 7 days
 * @method gene_cookie
 * @params {Object} res - Response Object
 * @params {String} userId
 * @params {String} name
 * @params {String} email
 */
function gene_cookie(res, userId, name, email) {
    res.cookie('user', {
        'id': userId,
        'name': name,
        'email': email
    }, {
        maxAge: 1000 * 3600 * 24 * 7
    });
};