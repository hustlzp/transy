###
User Model
###

mongoose = require('mongoose')
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

User = new Schema
  _id: ObjectId
  name: { type: String, index: true }
  email: { type: String, unique: true }
  pwd: String
  url: String
  avatarUrl: String
  location: String
  signature: String
  createTime: Date
  isActive: Boolean
  articleCount: { type: Number, default: 0, min: 0 }
  collectCount: { type: Number, default: 0, min: 0 }
  commentCount: { type: Number, default: 0, min: 0 }

User.statics.getByName = (name, callback)->
  this
  .findOne({ name: name })
  .exec callback

# add & reduce article count by 1
User.statics.addArticleCount = (userId, callback)->
  this.update { _id: userId }, { $inc: { articleCount: 1 }}, callback

User.statics.reduceArticleCount = (userId, callback)->
  this.update { _id: userId }, { $inc: { articleCount: -1 }}, callback

# add & reduce comment count by 1
User.statics.addCommentCount = (userId ,callback)->
  this.update { _id: userId }, { $inc: { commentCount: 1 }}, callback

User.statics.reduceCommentCount = (userId ,callback)->
  this.update { _id: userId }, { $inc: { commentCount: -1 }}, callback

# add & reduce collect count by 1
User.statics.addCollectCount = (userId ,callback)->
  this.update { _id: userId }, { $inc: { collectCount: 1 }}, callback

User.statics.reduceCollectCount = (userId ,callback)->
  this.update { _id: userId }, { $inc: { collectCount: -1 }}, callback

module.exports = mongoose.model('User', User)