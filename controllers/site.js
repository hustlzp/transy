/**
 * Home page
 */

var Article = require('../models/article');

exports.index = function(req, res){
  Article.find({}, function(err, data){
    // data.completion = parseInt(data.completion * 10000) / 100;
    res.render('index', {
      title: 'Transy',
      page: 'page-index',
      articles: data
    });
  });
}