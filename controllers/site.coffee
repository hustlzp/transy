###
Site Controller
###

Article = require('../models/article')

exports.index = (req, res)->
  Article
  .find({ completion: 100 })
  .populate('creator')
  .populate('col')
  .exec (err, data)->
    res.render('index', { articles: data })
      