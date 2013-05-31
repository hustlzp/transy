###
  Home page
###

Article = require('../models/article')

exports.index = (req, res)->
  Article.find({}, (err, data)->
    res.render('index',
      title: 'Transy'
      page: 'page-index'
      articles: data
    )
  )