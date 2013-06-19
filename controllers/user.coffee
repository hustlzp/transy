###
User Controller
###

url = require('url')
EventProxy = require('eventproxy')
User = require('../models/user')
Article = require('../models/article')
Topic = require('../models/topic')
Collect = require('../models/collect')
mongoose = require('mongoose')
ObjectId = mongoose.Types.ObjectId

# my personal page
exports.articles = (req, res)->
  User
  .findOne({ name: req.params.user })
  .exec (err, u)->
    Article
    .find({ creator: u.id })
    .populate('creator')
    .populate('topic')
    .exec (err, articles)->
      res.render('user/articles', { u: u, articles: articles })

# my love articles
exports.collect = (req, res)->
  User.findOne { name: req.params.user }, (err, u)->
    Collect
    .find({ user: u.id })
    .exec (err, collects)->
      ep = new EventProxy()
      ep.after 'got_article', collects.length, (articles)->
        res.render('user/collect', { u: u, articles: articles })
      for c in collects
        Article
        .findById(c.article)
        .populate('creator')
        .populate('topic')
        .exec (err, article)->
          ep.emit('got_article', article)

# my topics
exports.topics = (req, res)->
  User
  .findOne({ name: req.params.user })
  .exec (err, u)->
    Topic
    .find({ creator: u.id })
    .exec (err, cols)->
      res.render('user/topics', { u: u, cols: cols })

# user setting
exports.setting = (req, res)->
  User
  .findById(req.cookies.user.id)
  .exec (err, u)->
    res.render('user/settings', { u: u })
