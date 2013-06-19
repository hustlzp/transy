###
Collect Model
###

mongoose = require('mongoose')
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

Collect = new Schema
  _id: ObjectId
  user: { type: ObjectId, ref: 'User' }
  article: { type: ObjectId, ref: 'Article' }
  createTime: Date

module.exports = mongoose.model('Collect', Collect)