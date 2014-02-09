/**
 * User Model
 */

var crypto = require('crypto'),
    mongoose = require('mongoose'),
    Schema = mongoose.Schema,
    ObjectId = Schema.ObjectId;

User = new Schema({
    _id: ObjectId,
    name: {type: String, index: true},
    email: {type: String, unique: true},
    pwd: String,
    url: String,
    location: String,
    signature: String,
    createTime: { type: Date, "default": new Date() },
    isActive: { type: Boolean, "default": false },
    articleCount: { type: Number, "default": 0, min: 0 },
});

/*
 * Methods
 */

User.statics.getByName = function (name, callback) {
    this.findOne({
        name: name
    }).exec(callback);
};

User.statics.getByEmail = function (email, callback) {
    this.findOne({
        email: email
    }).exec(callback);
};

User.statics.getByEmailAndPwd = function (email, pwd, callback) {
    this.findOne({
        email: email,
        pwd: md5(pwd)
    }).exec(callback);
};

User.statics.add = function (userId, name, email, pwd, callback) {
    this.create({
        _id: userId,
        name: name,
        email: email,
        pwd: md5(pwd)
    }, callback);
};

User.statics.addArticleCount = function (userId, callback) {
    this.update({_id: userId}, {$inc: {articleCount: 1}}, callback);
};

User.statics.reduceArticleCount = function (userId, callback) {
    this.update({_id: userId}, {$inc: {articleCount: -1}}, callback);
};

/*
 * Get md5 value of a string
 * @method md5
 * @params {String} str - The string to be md5
 * @return {String} md5 value of the string
 */
function md5(str) {
    var hash;
    hash = crypto.createHash('md5');
    hash.update(str);
    return hash.digest('hex');
};

module.exports = mongoose.model('User', User);