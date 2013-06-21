###
Article Collect Model
###

mongoose = require('mongoose')
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

Collect = new Schema
  _id: ObjectId
  user: { type: ObjectId, ref: 'User' }
  article: { type: ObjectId, ref: 'Article' }
  createTime: { type: Date, default: new Date() }

Collect.statics.getByUser = (userId, callback)->
  this
  .find({ user: userId })
  .exec callback

Collect.statics.check = (userId, articleId, callback)->
  this
  .findOne({ user: userId, article: articleId })
  .exec callback

Collect.statics.add = (userId, articleId, callback)->
  this.create
    user: userId
    article: articleId
    createTime: new Date()
  , callback

Collect.statics.removeByUserAndArticle = (userId, articleId, callback)->
  this.remove { user: userId, article: articleId }, callback

module.exports = mongoose.model('Collect', Collect)