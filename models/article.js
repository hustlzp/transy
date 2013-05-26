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
  completion: Number,
  createTime: Date,
  updateTime: Date,
  paraList: [Para],
  commentList: [String]
});

exports.Article = mongoose.model('Article', Article);