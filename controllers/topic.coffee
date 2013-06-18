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
  Topic
  .find()
  .exec (err, topics)->
    res.render('topic/topics', { topics: topics })

# single topic
exports.topic = (req, res)->
  Topic
  .findById(req.params.id)
  .exec (err, topic)->
    Article
    .find({ topic: req.params.id })
    .populate('creator')
    .populate('topic')
    .exec (err, articles)->
      res.render('topic/topic', { topic: topic, articles: articles })

# add topic page
exports.showAdd = (req, res)->
  res.render('topic/add_topic')

# add topic
exports.add = (req, res)->
  if req.form.isValid
    t = new Topic
      _id: new ObjectId()
      creator: req.cookies.user.id
      type: req.form.type
      title: req.form.title
      intro: req.form.intro
      image: req.form.image
    t.save (err)->
      if not err
        res.redirect("/topic/#{t._id}")
      else
        next(err)
  else
    res.render('topic/add_topic', { form: req.form })

# # edit topic page
# exports.showEdit = (req, res)->
#   Topic
#   .findById(req.params.id)
#   .exec (err, data)->
#     if not err
#       res.render('topic/edit_topic', { cid: data.id, form: data })
#     else
#       next(err)

# # edit topic
# exports.edit = (req, res)->
#   if req.form.isValid
#     Topic
#     .findById(req.params.id)
#     .exec (err, data)->
#       data.type = req.form.type
#       data.title = req.form.title
#       data.intro = req.form.intro
#       data.image = req.form.intro
#       data.save (err)->
#         res.redirect("/topic/#{data.id}")
#   else
#     res.render('topic/edit_topic',
#       cid: req.params.id
#       form: req.form
#     )

# edit topic
exports.edit = (req, res)->
  Topic
  .findById(req.params.id)
  .exec (err, topic)->
    switch req.method
      when 'GET'
        res.render('topic/edit_topic', { tid: topic.id, form: topic })
      when 'POST'
        if req.form.isValid
          topic.type = req.form.type
          topic.title = req.form.title
          topic.intro = req.form.intro
          topic.image = req.form.image
          topic.save (err)->
            res.redirect("/topic/#{topic.id}")
        else
          res.render('topic/edit_topic', { tid: topic.id, form: req.form })

# delete topic
exports.delete = (req, res)->
  Tsopic
  .remove(_id: req.params.id)
  .exec (err, data)->
    res.redirect('/topics')