###
Article Collection Model
###

mongoose = require('mongoose')
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

Collection = new Schema
  _id: ObjectId
  creator: { type: ObjectId, ref: 'User' }
  articleCount: { type: Number, default: 0 }
  type: String
  title: String
  intro: String
  image: String

module.exports = mongoose.model('Collection', Collection)