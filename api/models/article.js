/**
 * Article Model
 */

var url = require('url'),
  mongoose = require('mongoose'),
  Schema = mongoose.Schema,
  ObjectId = Schema.ObjectId,
  User = require('./user');

Para = new Schema({
  en: String,
  cn: String,
  type: String,
  state: Boolean
});

Article = new Schema({
  _id: ObjectId,
  creator: { type: ObjectId, ref: 'User' },
  enTitle: String,
  cnTitle: String,
  url: String,
  author: String,
  completion: { type: Number, "default": 0, min: 0, max: 100 },
  createTime: { type: Date, "default": new Date() },
  updateTime: { type: Date, "default": new Date() },
  paraList: [Para],
  annotationList: [String],
  collectCount: { type: Number, "default": 0, min: 0 },
  commentCount: { type: Number, "default": 0, min: 0 }
});

/*
 * Properties
 */

Article.virtual('urlHost').get(function () {
  return url.parse(this.url).hostname;
});


/*
 * Methods
 */

Article.statics.getById = function (articleId, callback) {
  this.findById(articleId).exec(callback);
};

Article.statics.getByUser = function (userId, callback) {
  this.find({
    creator: new mongoose.Types.ObjectId(userId)
  }).exec(callback);
};

Article.statics.add = function (articleId, userId, data, callback) {
  var article, p, paras, _i, _len;
  article = new this({
    _id: articleId,
    creator: userId,
    enTitle: data.enTitle,
    cnTitle: '待译标题',
    url: data.url,
    author: data.author,
    abstract: '',
    paraList: []
  });
  paras = data.content.split('\n');
  for (_i = 0, _len = paras.length; _i < _len; _i++) {
    p = paras[_i];
    if (p.trim() !== '') {
      article.paraList.push({
        en: p.trim(),
        cn: '',
        type: 'text',
        state: false
      });
    }
  }
  article.save(callback);
};

Article.statics.edit = function (articleId, article, callback) {
  // 由于MongoDB在更新操作时，不允许修改_id，因此这里需要将_id删除
  delete article._id;
  // 这里的this表示当前实例
  this.findByIdAndUpdate(articleId, article, callback);
};

Article.statics.removeById = function (articleId, callback) {
  this.findByIdAndRemove(articleId, function (err, article) {
    User.reduceArticleCount(article.creator, callback);
  });
};

module.exports = mongoose.model('Article', Article);