###
Article Controller
###

url = require('url')
EventProxy = require('eventproxy')
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
  Topic.findById req.params.tid, (err, topic)->
    res.render('article/add_article', { topic: topic })

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
  articleId = req.params.id

  epa = new EventProxy();
  epa.all 'rm_article', 'rm_comments', 'rm_collects', ->
    res.redirect("u/#{req.cookies.user.name}")

  # remove article
  Article.findByIdAndRemove articleId , (err, article)->
    # article count - 1 in Topic
    Topic.reduceArticleCount article.topic, (err)->
      # article count - 1 in User
      User.reduceArticleCount article.creator, (err)->
        epa.emit('rm_article')

  # remove comments
  Comment.getByArticle articleId, (err, comments)->
    epb = new EventProxy()
    epb.after 'rm_comment', comments.length, ->
      epa.emit('rm_comments')

    for c in comments
      Comment.findByIdAndRemove c.id, (err, c)->
        # comment count - 1 in User
        User.reduceCommentCount c.user, (err)->
          epb.emit('rm_comment')

  # remove collects
  Collect.getByArticle articleId, (err, collects)->
    epc = new EventProxy()
    epc.after 'rm_collect', collects.length, ->
      epa.emit('rm_collects')

    for c in collects
      Collect.findByIdAndRemove c.id, (err, c)->
        # collect count - 1 in User
        User.reduceCollectCount c.user, (err)->
          epc.emit('rm_collect')


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

# State var: if is displaying a list
inList = false
enListHTML = ""
cnListHTML = ""

# output article
exports.output = (req, res)->
  Article.findById req.params.id , (err, data)->
    html = ''
    for p in data.paraList
      switch req.params.mode
        when 'en'
          if p.type == 'list'
            if not inList
              inList = true
              enListHTML = ""
            enListHTML += outputHTML(p.type, p.en) + "\n"
          else
            if p.type != 'list'
              if inList
                inList = false
                html += "<ul>\n" + enListHTML + "</ul>"
                html += "\n\n"
              html += outputHTML(p.type, p.en)
              html += "\n\n"
        when 'cn'
          if p.type == 'list'
            if not inList
              inList = true
              cnListHTML = ""
            cnListHTML += outputHTML(p.type, p.cn) + "\n"
          else
            if p.type != 'list'
              if inList
                inList = false
                html += "<ul>\n" + cnListHTML + "</ul>"
                html += "\n\n"
              html += outputHTML(p.type, p.cn)
              html += "\n\n"
        when 'ec'
          if p.type == 'list'
            if not inList
              inList = true
              enListHTML = ""
              cnListHTML = ""
            enListHTML += outputHTML(p.type, p.en) + "\n"
            cnListHTML += outputHTML(p.type, p.cn) + "\n"
          else
            if p.type != 'list'
              if inList
                inList = false
                html += "<ul>\n" + enListHTML + "</ul>"
                html += "\n"
                html += "<ul>\n" + cnListHTML + "</ul>"
                html += "\n\n"
              html += outputHTML(p.type, p.en)
              html += "\n"
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
      html = "<p><img src='#{content}' /></p>"
    when 'quote'
      html = "<blockquote>#{content}</blockquote>"
    when 'list'
      html = "    <li>#{content}</li>"

  return html