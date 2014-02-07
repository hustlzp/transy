/**
 * Site Controller
 */

var Article = require('../models/article');

exports.index = function (req, res) {
    if (req.cookies.user) {
        Article.getByUser(req.cookies.user.id, function (err, articles) {
            res.render('site/index', { articles: articles });
        });
    } else {
        res.render('account/signin');
    }
};

exports.about = function (req, res) {
    res.render('site/about');
};
