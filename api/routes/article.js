/*
 * Article API.
 */

var Article = require('../models/article')


exports.list = function (req, res) {
  Article.find(function (err, articles) {
    res.json(articles);
  });
};

exports.single = function (req, res) {
  Article.getById(req.params.id, function (err, article) {
    res.json(article);
  });
}

exports.update = function (req, res) {
  Article.edit(req.params.id, req.body, function (err, article) {
    if (!err) {
      res.send(article);
    } else {
      res.send(500, err);
    }
  });
}

exports['delete'] = function (req, res) {
  var articleId = req.params.id;
  Article.findByIdAndRemove(articleId, function (err, article) {
    /*
    User.reduceArticleCount(article.creator, function (err) {
      res.redirect("/");
    });
    */
    if (!err) {
      res.send(200, 'deleted');
    } else {
      res.send(500, err);
    }
  });
}