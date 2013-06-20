###
Article Comment Model
###

mongoose = require('mongoose')
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

Comment = new Schema
  _id: ObjectId
  user: { type: ObjectId, ref: 'User' }
  article: { type: ObjectId, ref: 'Article' }
  content: String
  createTime: Date

Comment.statics.getByUser = (userId, callback)->
  this
  .find({ user: userId })
  .populate('user')
  .populate('article')
  .exec callback

# get comments by article id
Comment.statics.getByArticle = (articleId, callback)->
  this
  .find({ article: articleId })
  .populate('user')
  .exec callback

# new
Comment.statics.add = (articleId, userId, content, callback)->
  this.create
    article: articleId
    user: userId
    content: content
    createTime: new Date()
  , callback

module.exports = mongoose.model('Comment', Comment)