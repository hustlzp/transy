###
Message Model
###

mongoose = require('mongoose')
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

Message = new Schema
  _id: ObjectId
  user: { type: ObjectId, ref: 'User' }
  content: String
  createTime: Date

module.exports = mongoose.model('Message', Message)