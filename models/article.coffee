###
Article Model
###

mongoose = require('mongoose')
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

Para = new Schema
  en: String
  cn: String
  type: String
  state: Boolean

Article = new Schema
  _id: ObjectId
  creator: { type: ObjectId, ref: 'User' }
  topic: { type: ObjectId, ref: 'Topic' }
  enTitle: String
  cnTitle: String
  url: String
  urlHost: String
  author: String
  completion: Number
  createTime: Date
  updateTime: Date
  paraList: [Para]
  # commentList: [String]
  collectCount: { type: Number, default: 0 }
  commentCount: { type: Number, default: 0 }

module.exports = mongoose.model('Article', Article)