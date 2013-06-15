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
  enTitle: String
  cnTitle: String
  userId: Object
  url: String
  creatorId: ObjectId
  author: String
  # abstract: String
  completion: Number
  createTime: Date
  updateTime: Date
  paraList: [Para]
  commentList: [String]

module.exports = mongoose.model('Article', Article)