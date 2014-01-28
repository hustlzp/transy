/*
 * Site Controller
 */

var Article = require('../models/article');

exports.index = function (req, res) {
    Article.getByUser(req.cookies.id, function (err, articles) {
        res.render('index', {
            articles: articles
        });
    });
};

exports.about = function (req, res) {
    res.render('about');
};
