/*
 * Article API.
 */

var Article = require('../models/article')


exports.list = function (req, res) {
  Article.find(function (err, articles) {
    res.header('Access-Control-Allow-Origin', 'http://127.0.0.1:9000');
    res.json(articles);
  });
};

exports.single = function(req, res){
  Article.getById(req.params.id, function(err, article){
    res.header('Access-Control-Allow-Origin', 'http://127.0.0.1:9000');
    res.json(article);
  });
}