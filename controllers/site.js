/**
 * Site Controller
 */

var Article = require('../models/article');

exports.index = function (req, res) {
    Article.getByUser(req.cookies.user.id, function (err, articles) {
        res.render('site/index', { articles: articles });
    });
};

exports.about = function (req, res) {
    res.render('site/about');
};
