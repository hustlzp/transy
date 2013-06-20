###
Article Model
###

# business = require('../business/article')
url = require('url')
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
  annotationList: [String]
  collectCount: { type: Number, default: 0, min: 0 }
  commentCount: { type: Number, default: 0, min: 0 }

# get hot articles
Article.statics.getHot = (num, callback)->
  this
  .find()
  .sort({ commentCount: -1, collectCount: -1 })
  .limit(num)
  .exec callback

# get new articles
Article.statics.getNew = (num, callback)->
  this
  .find({ completion: 100 })
  .populate('creator')
  .populate('topic')
  .sort({ createTime: -1 })
  .limit(num)
  .exec callback

# get by id
Article.statics.getById = (id, callback)->
  this
  .findById(id)
  .populate('creator')
  .populate('topic')
  .exec callback

# new
Article.statics.add = (articleId, userId, topicId, enTitle, content, articleUrl, author, callback)->
  article = new this
    _id: articleId
    creator: userId
    topic: topicId
    enTitle: enTitle
    cnTitle: '待译标题'
    url: articleUrl
    urlHost: url.parse(articleUrl).hostname
    author: author
    completion: 0
    abstract: ''
    createTime: new Date()
    updateTime: new Date()
    paraList: []

  # slice the paragraph by \n
  paras = content.split('\n')
  for p in paras when p.trim() != ''
    article.paraList.push
      en: p.trim()
      cn: ''
      type: 'text'
      state: false

  article.save callback

# update
Article.statics.edit = (articleId, article, callback)->
  this.update { _id: articleId },
    enTitle: article.enTitle
    cnTitle: article.cnTitle
    author: article.author
    url: article.url
    urlHost: url.parse(article.url).hostname
    abstract: article.abstract
    completion: article.completion
    paraList: article.paraList
  , callback

Article.statics.addCommentCount = (articleId, callback)->
  this.update { _id: articleId }, { $inc: { commentCount: 1 }}, callback

Article.statics.reduceCommentCount = (articleId, callback)->
  this.update { _id: articleId }, { $inc: { commentCount: -1 }}, callback

Article.statics.addCollectCount = (articleId, callback)->
  this.update { _id: articleId }, { $inc: { collectCount: 1 }}, callback

Article.statics.reduceCollectCount = (articleId, callback)->
  this.update { _id: articleId }, { $inc: { collectCount: -1 }}, callback

module.exports = mongoose.model('Article', Article)