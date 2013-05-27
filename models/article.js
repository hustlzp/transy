/**
 * Article Model
 */

var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var Para = new Schema({
  en: String,
  cn: String,
  type: String,
  state: Boolean
});

var Article = new Schema({
  enTitle: String,
  cnTitle: String,
  url: String,
  abstract: String,
  completion: Number,
  createTime: Date,
  updateTime: Date,
  paraList: [Para],
  commentList: [String]
});

module.exports = mongoose.model('Article', Article);