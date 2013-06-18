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
  articleCount: { Type: Number, default: 0 }
  collectCount: { Type: Number, default: 0 }

module.exports = mongoose.model('User', User)