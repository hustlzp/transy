###
Topic Model
###

mongoose = require('mongoose')
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

Topic = new Schema
  _id: ObjectId
  creator: { type: ObjectId, ref: 'User' }
  articleCount: { type: Number, default: 0, min: 0 }
  type: String
  title: String
  intro: String
  image: String

# new
Topic.statics.add = (topicId, userId, type, title, intro, image)->
  topic = new Topic
    _id: topicId
    creator: userId
    type: type
    title: title
    intro: intro
    image: image
  topic.save callback

# edit
Topic.statics.edit = (topicId, type, title, intro, image)->
  Topic.update { _id: topicId },
    type: type
    title: title
    intro: intro
    image: image
  , callback

# add & reduce article count by 1
Topic.statics.addArticleCount = (topicId, callback)->
  this.update { _id: topicId }, { $inc: { articleCount: 1 }}, callback

Topic.statics.reduceArticleCount = (topicId, callback)->
  this.update { _id: topicId }, { $inc: { articleCount: -1 }}, callback

module.exports = mongoose.model('Topic', Topic)