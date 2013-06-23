###
topic Controller
###

url = require('url')
Topic = require('../models/topic')
Article = require('../models/article')
mongoose = require('mongoose')
ObjectId = mongoose.Types.ObjectId

# topics
exports.topics = (req, res)->
  Topic.find {}, (err, topics)->
    res.render('topic/topics', { topics: topics })

# single topic
exports.topic = (req, res)->
  Topic.findById req.params.id, (err, topic)->
    Article.getByTopic req.params.id, (err, articles)->
      res.render('topic/topic', { topic: topic, articles: articles })

# add topic page
exports.showAdd = (req, res)->
  res.render('topic/add_topic')

# add topic
exports.add = (req, res)->
  if req.form.isValid
    topicId = new ObjectId()
    creator = req.cookies.user.id
    # type = req.form.type
    type = 'culture'
    title = req.form.title
    intro = req.form.intro
    Topic.add topicId, creator, type, title, intro, (err)->
      res.redirect("/topic/#{topicId}")
  else
    res.render('topic/add_topic', { form: req.form })

# edit topic page
exports.showEdit = (req, res)->
  Topic.findById req.params.id, (err, topic)->
    res.render('topic/edit_topic', { tid: req.params.id, form: topic })

# edit topic
exports.edit = (req, res)->
  if req.form.isValid
    topicId = req.params.id
    type = req.form.type
    title = req.form.title
    intro = req.form.intro
    image = req.form.image
    Topic.edit topicId, type, title, intro, image, (err)->
      res.redirect("/topic/#{topicId}")
  else
    res.render('topic/edit_topic', { tid: topicId, form: req.form })

# delete topic
exports.delete = (req, res)->
  Topic.remove { _id: req.params.id }, (err)->
    res.redirect('/topics')