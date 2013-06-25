###
Article Comment Model
###

moment = require('moment')
mongoose = require('mongoose')
Schema = mongoose.Schema
ObjectId = Schema.ObjectId
User = require('./user')
EventProxy = require('eventproxy')

Comment = new Schema
  _id: ObjectId
  user: { type: ObjectId, ref: 'User' }
  article: { type: ObjectId, ref: 'Article' }
  content: String
  createTime: { type: Date, default: new Date() }

# Getter of createTime
Comment.path('createTime').get (time)->
  # return moment(time).add('m', 10).format('YYYY/M/D H:mm').fromNow()
  return moment(time).fromNow()

# get comments by user, sort by time asc
Comment.statics.getByUser = (userId, callback)->
  this
  .find({ user: userId })
  .sort({ createTime: 1 })
  .populate('user')
  .populate('article')
  .exec callback

# get comments by article, sort by time desc
Comment.statics.getByArticle = (articleId, callback)->
  this
  .find({ article: articleId })
  .sort({ createTime: -1 })
  .populate('user')
  .populate('article')
  .exec callback

# new
Comment.statics.add = (articleId, userId, content, callback)->
  this.create
    article: articleId
    user: userId
    content: content
    createTime: new Date()
  , callback

# Comment.statics.removeByArticle = (articleId, callback)->
#   Model = this

#   Model.getByArticle articleId, (err, comments)->
#     ep = new EventProxy()
#     ep.after 'rm_comment', comments.length, callback

#     for c in comments
#       Model.findByIdAndRemove c.id, (err, c)->
#         # comment count - 1 in User
#         User.reduceCommentCount c.user, (err)->
#           ep.emit('rm_comment')

module.exports = mongoose.model('Comment', Comment)