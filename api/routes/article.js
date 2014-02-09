/*
 * Article API.
 */

var Article = require('../models/article')


exports.list = function (req, res) {
  Article.find(function (err, articles) {
    res.json(articles);
  });
};