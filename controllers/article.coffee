###
Article Controller
###

Article = require('../models/article')

# show single article
exports.article = (req, res)->
  Article.findById(req.params.id, (err, data)->
    res.render("article/article",
      title: 'Article'
      page: 'page-article'
      article: data 
    )
  )

# show add article page
exports.showAdd = (req, res)->
  res.render('article/add_article', 
    title: 'Add article'
    page: 'page-add-article'
  )

# new article
exports.add = (req, res)->
  article = new Article
    enTitle: req.body.title
    url: req.body.url
    completion: 0
    createTime: new Date()
    updateTime: new Date()
    paraList: []

  # slice the paragraph by \n
  paras = req.body.content.split('\n')
  for p in paras when p.trim() != ''
    article.paraList.push
      en: p.trim()
      cn: ''
      type: 'text'
      state: false

  article.save((err)->
    if(!err)
      res.redirect('/')
    else
      res.redirect('/article/add')
  )

# show edit page
exports.showEdit = (req, res)->
  Article.findById(req.params.id, (err, data)->
    res.render("article/edit_article",  
      title: 'Edit article'
      page: 'page-edit-article'
      article: data 
    )
  )

# update article
exports.edit = (req, res)->
  Article.findById(req.params.id, (err, data)->
    a = req.body.article
    data.enTitle = a.enTitle
    data.cnTitle = a.cnTitle
    data.url = a.url
    data.abstract = a.abstract
    data.completion = a.completion
    data.paraList = a.paraList

    data.save((err)->
      if(!err)
        res.send(200,  result: 1 )
      else
        res.send(500,  result: 0 )
    )
  )

# delete article
exports.delete = (req, res)->
  Article.remove(_id: req.params.id , (err)->
    if(!err)
      res.redirect('/')
    else
      res.redirect('/article/' + req.params.id)
  )
