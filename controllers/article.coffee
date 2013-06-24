###
Article Controller
###

url = require('url')
User = require('../models/user')
Topic = require('../models/topic')
Article = require('../models/article')
Collect = require('../models/collect')
Comment = require('../models/comment')
mongoose = require('mongoose')
ObjectId = mongoose.Types.ObjectId

# show single article
exports.article = (req, res)->
  articleId = req.params.id
  Article.getById articleId, (err, article)->
    Comment.getByArticle articleId, (err, comments)->
      if not req.cookies.user
        res.render("article/article", { article: article, comments: comments, isCollect: false })
      else
        Collect.check req.cookies.user.id, articleId, (err, collect)->
          isCollect = if collect then true else false
          res.render("article/article", { article: article, comments: comments, isCollect: isCollect })

# show add article page
exports.showAdd = (req, res)->
  res.render('article/add_article', { tid: req.params.tid })

# new article
exports.add = (req, res)->
  if req.form.isValid
    # new article
    articleId = new ObjectId()
    userId = req.cookies.user.id
    topicId = req.params.tid
    enTitle = req.body.title
    content = req.body.content
    url = req.body.url
    author = req.body.author
    Article.add articleId, userId, topicId, enTitle, content, url, author, (err)->
      # article count + 1 in Topic
      Topic.addArticleCount topicId, (err)->
        # article count + 1 in User
        User.addArticleCount userId, (err)->
          res.redirect("/article/#{articleId}")
  else
    res.render('article/add_article', { tid: req.params.tid, form: req.form })

# show edit page
exports.showEdit = (req, res)->
  Article.getById req.params.id, (err, article)->
    res.render("article/edit_article", { article: article }) 

# update article
exports.edit = (req, res)->
  Article.edit req.params.id, req.body.article, (err)->
    if not err
      res.send(200, { result: 1 })
    else
      res.send(500, { result: 0 })

# delete article
exports.delete = (req, res)->
  Article.findByIdAndRemove req.params.id , (err, article)->
    # article count - 1 in Topic
    Topic.reduceArticleCount article.topic, (err)->
      # article count - 1 in User
      User.reduceArticleCount article.creator, (err)->
        res.redirect("/u/#{req.cookies.user.name}")

# add comment
exports.comment = (req, res)->
  if req.body.content.trim() == ''
    return res.redirect("/article/#{req.params.id}")

  articleId = req.params.id
  userId = req.cookies.user.id
  Comment.add articleId, userId, req.body.content.trim(), (err)->
    # comment count + 1 in Article
    Article.addCommentCount articleId, (err)->
      # comment count + 1 in User
      User.addCommentCount userId, (err)->
        res.redirect("/article/#{articleId}")

# remove comment
exports.discomment = (req, res)->
  Comment.findByIdAndRemove req.params.id, (err, comment)->
    # comment count - 1 in Article
    Article.reduceCommentCount comment.article, (err)->
      # comment count - 1 in User
      User.reduceCommentCount comment.user, (err)->
        res.redirect("/article/#{comment.article}")

# collect article
exports.collect = (req, res)->
  userId = req.cookies.user.id
  articleId = req.params.id
  Collect.add userId, articleId, (err)->
    # collect count + 1 in User
    User.addCollectCount userId, (err)->
      # collect count + 1 in Article
      Article.addCollectCount articleId, (err)->
        res.redirect("/article/#{articleId}")

# discollect article
exports.discollect = (req, res)->
  userId = req.cookies.user.id
  articleId = req.params.id
  Collect.removeByUserAndArticle userId, articleId, (err)->
    # collect count - 1 in User
    User.reduceCollectCount userId, (err)->
      # collect count - 1 in Article
      Article.reduceCollectCount articleId, (err)->
        res.redirect("/article/#{articleId}")

# output article
exports.output = (req, res)->
  Article.findById req.params.id , (err, data)->
    html = ''
    for p in data.paraList
      switch req.params.mode
        when 'en'
          html += outputHTML(p.type, p.en)
        when 'cn'
          html += outputHTML(p.type, p.cn)
        when 'ec'
          html += outputHTML(p.type, p.en)
          if p.cn != '' and p.type != 'image'
            html += '\n'
            html += outputHTML(p.type, p.cn)
      html += "\n\n"

    res.set('Content-Type', 'text/plain;charset=utf-8')
    res.send(200, html)

###
Output html
@params {String} type - the type of para
@params
###
outputHTML = (type, content)->
  switch type
    when 'header'
      html = "<h3>#{content}</h3>"
    when 'text'
      html = "<p>#{content}</p>"
    when 'image'
      html = "<p><img scr='#{content}' /></p>"
    when 'quote'
      html = "<blockquote>#{content}</blockquote>"
  html