/**
 * Home page
 */

var mongoose = require('mongoose');
var Article = require('../models/article').Article;

mongoose.connect('mongodb://localhost:27017/transy')

exports.index = function(req, res){
  
  var article = new Article({
    enTitle: "How to get startup ideas",
    cnTitle: "三",
    url: "http://paulgraham.com/startupideas.html",
    completion: 4,
    updateTime: new Date(),
    createTime: new Date(),

    paraList: [
      {
        en: "The way to get startup ideas is not to try to think of startup ideas. It's to look for problems, preferably problems you have yourself.",
        cn: "",
        type: "para",
        state: true
      },

      {
        en: "The very best startup ideas tend to have three things in common: they're something the founders themselves want, that they themselves can build, and that few others realize are worth doing. Microsoft, Apple, Yahoo, Google, and Facebook all began this way.",
        cn: "",
        type: "para",
        state: true
      }
    ],

    commentList: []
  });
  //article.save();

  Article.find({}, function(err, data){
    res.render('index', { title: 'Transy', articles: data });
  });
  //res.render('index', { title: 'Transy' });
}