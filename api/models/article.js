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
    this.findById(articleId).populate('creator').exec(callback);
};

Article.statics.getByUser = function (userId, callback) {
    this.find({
        creator: new mongoose.Types.ObjectId(userId)
    }).populate('creator').exec(callback);
};

Article.statics.add = function (articleId, userId, enTitle, content, articleUrl, author, callback) {
    var article, p, paras, _i, _len;
    article = new this({
        _id: articleId,
        creator: userId,
        enTitle: enTitle,
        cnTitle: '待译标题',
        url: articleUrl,
        author: author,
        abstract: '',
        paraList: []
    });
    paras = content.split('\n');
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
    this.update({ _id: articleId }, {
        enTitle: article.enTitle,
        cnTitle: article.cnTitle,
        author: article.author,
        url: article.url,
        abstract: article.abstract,
        completion: article.completion,
        paraList: article.paraList
    }, callback);
};

Article.statics.removeById = function (articleId, callback) {
    this.findByIdAndRemove(articleId, function (err, article) {
        User.reduceArticleCount(article.creator, callback);
    });
};

module.exports = mongoose.model('Article', Article);