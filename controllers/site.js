/**
 * Home page
 */

var Article = require('../models/article');

exports.index = function(req, res){
  Article.find({}, function(err, data){
    res.render('index', {
      title: 'Transy',
      page: 'page-index',
      articles: data
    });
  });
}