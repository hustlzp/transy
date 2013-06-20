###
Site Controller
###

Article = require('../models/article')

exports.index = (req, res)->
  Article
  .find({ completion: 100 })
  .populate('creator')
  .populate('topic')
  .sort({ createTime: -1 })
  .limit(10)
  .exec (err, articles)->
    Article
    .find()
    .sort({ commentCount: -1, collectCount: -1 })
    .limit(10)
    .exec (err, hotArticles)->
      res.render('index', { articles: articles, hotArticles: hotArticles })