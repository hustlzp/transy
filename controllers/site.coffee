###
Site Controller
###

Article = require('../models/article')

exports.index = (req, res)->
  Article.find({}, (err, data)->
    res.render('index',
      articles: data
    )
  )