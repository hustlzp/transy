###
User Controller
###

url = require('url')
Article = require('../models/article')
mongoose = require('mongoose')
ObjectId = mongoose.Types.ObjectId

# my personal page
exports.me = (req, res)->
  Article.find { creator: req.cookies.user.id }, (err, data)->
    res.render('user/me', { articles: data })

# my love articles
exports.love = (req, res)->
  res.render('user/love')

# my collections
exports.collections = (req, res)->
  res.render('user/collections')