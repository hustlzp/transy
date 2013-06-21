###
User Model
###

crypto = require('crypto')
mongoose = require('mongoose')
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

User = new Schema
  _id: ObjectId
  name: { type: String, index: true }
  email: { type: String, unique: true }
  pwd: String
  url: String
  avatarUrl: { type: String, default: "/default.png" }
  location: String
  signature: String
  createTime: { type: Date, default: new Date() }
  isActive: { type: Boolean, default: false }
  articleCount: { type: Number, default: 0, min: 0 }
  collectCount: { type: Number, default: 0, min: 0 }
  commentCount: { type: Number, default: 0, min: 0 }

# get user by name
User.statics.getByName = (name, callback)->
  this
  .findOne({ name: name })
  .exec callback

# get user by email
User.statics.getByEmail = (email, callback)->
  this
  .findOne({ email: email })
  .exec callback

User.statics.getByEmailAndPwd = (email, pwd, callback)->
  this
  .findOne({ email: email, pwd: md5(pwd) })
  .exec callback

# new
User.statics.add = (userId, name, email, pwd, callback)->
  this.create
    _id: userId
    name: name
    email: email
    pwd: md5(pwd)
  , callback    

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

###
Get md5 value of a string
@method md5
@params {String} str - The string to be md5
@return {String} md5 value of the string
###
md5 = (str)->
  hash = crypto.createHash('md5')
  hash.update(str)
  hash.digest('hex')