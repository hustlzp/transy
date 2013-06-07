###
User Model
###

mongoose = require('mongoose')
Schema = mongoose.Schema

User = new Schema
  name: String
  email: String
  pwd: String

module.exports = mongoose.model('User', User)