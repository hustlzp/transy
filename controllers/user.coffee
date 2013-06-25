###
User Controller
###

url = require('url')
EventProxy = require('eventproxy')
User = require('../models/user')
Article = require('../models/article')
Topic = require('../models/topic')
Collect = require('../models/collect')
Comment = require('../models/comment')
mongoose = require('mongoose')
ObjectId = mongoose.Types.ObjectId

# user articles
exports.articles = (req, res)->
  User.getByName req.params.user, (err, u)->
    Article.getByUser u.id, (err, articles)->
      res.render('user/articles', { u: u, articles: articles })

# user collects
exports.collects = (req, res)->
  User.getByName req.params.user, (err, u)->
    Collect.getByUser u.id, (err, collects)->
      # use EventProxy to get articles from collects
      ep = new EventProxy()
      ep.after 'got_article', collects.length, (articles)->
        res.render('user/collects', { u: u, articles: articles })
      for c in collects
        Article.getById c.article, (err, article)->
          ep.emit('got_article', article)

# user comments
exports.comments = (req, res)->
  User.getByName req.params.user, (err, u)->
    Comment.getByUser u.id, (err, comments)->
      res.render('user/comments', { u: u, comments: comments })

# show my setting page
exports.showSetting = (req, res)->
  User.findById req.cookies.user.id, (err, u)->
    res.render('user/setting', { u: u })

# setting
exports.setting = (req, res)->
  User.findById req.cookies.user.id, (err, u)->
    res.render('user/setting', { u: u })
