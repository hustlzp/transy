###
Site Controller
###

Article = require('../models/article')

exports.index = (req, res)->
  Article
  .find()
  .populate('creator')
  .exec (err, data)->
    res.render('index', { articles: data })
      