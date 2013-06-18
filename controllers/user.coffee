###
User Controller
###

url = require('url')
User = require('../models/user')
Article = require('../models/article')
Collection = require('../models/collection')
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
    .populate('col')
    .exec (err, articles)->
      res.render('user/articles', { u: u, articles: articles })

# my love articles
exports.love = (req, res)->
  User
  .findOne({ name: req.params.user })
  .exec (err, u)->
    res.render('user/love', { u: u })

# my collections
exports.collections = (req, res)->
  User
  .findOne({ name: req.params.user })
  .exec (err, u)->
    Collection
    .find({ creator: u.id })
    .exec (err, cols)->
      res.render('user/collections', { u: u, cols: cols })