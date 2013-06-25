###
Site Controller
###

Article = require('../models/article')

exports.index = (req, res)->
  Article.getNew 10, (err, articles)->
    Article.getHot 10, (err, hotArticles)->
      res.render('index', { articles: articles, hotArticles: hotArticles })

exports.about = (req, res)->
  res.render('about')
