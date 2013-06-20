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

module.exports = mongoose.model('User', User)