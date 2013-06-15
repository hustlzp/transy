###
User Love Model
###

mongoose = require('mongoose')
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

Love = new Schema
  _id: ObjectId
  user: { Type: ObjectId, ref: 'User' }
  article: { Type: ObjectId, ref: 'Article' }
  time: Date

module.exports = mongoose.model('Love', User)