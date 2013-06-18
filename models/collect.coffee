###
Collect Model
###

mongoose = require('mongoose')
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

Collect = new Schema
  _id: ObjectId
  user: { Type: ObjectId, ref: 'User' }
  article: { Type: ObjectId, ref: 'Article' }
  createTime: Date

module.exports = mongoose.model('Collect', Collect)