/**
 * Article Controller
 */

var url = require('url'),
    EventProxy = require('eventproxy'),
    User = require('../models/user'),
    Article = require('../models/article'),
    mongoose = require('mongoose'),
    ObjectId = mongoose.Types.ObjectId;

exports.article = function (req, res) {
    var articleId = req.params.id;
    Article.getById(articleId, function (err, article) {
        res.render("article/article", { article: article });
    });
};

exports.showAdd = function (req, res) {
    res.render('article/add');
};

exports.add = function (req, res) {
    var articleId, author, content, enTitle, userId;
    if (req.form.isValid) {
        articleId = new ObjectId();
        userId = req.cookies.user.id;
        enTitle = req.body.title;
        content = req.body.content;
        url = req.body.url;
        author = req.body.author;
        Article.add(articleId, userId, enTitle, content, url, author, function (err) {
            User.addArticleCount(userId, function (err) {
                res.redirect("/article/" + articleId);
            });
        });
    } else {
        res.render('article/add', { form: req.form });
    }
};

exports.showEdit = function (req, res) {
    Article.getById(req.params.id, function (err, article) {
        res.render("article/edit", { article: article });
    });
};

exports.edit = function (req, res) {
    Article.edit(req.params.id, req.body.article, function (err) {
        if (!err) {
            res.send(200, {result: 1});
        } else {
            res.send(500, {result: 0});
        }
    });
};

exports["delete"] = function (req, res) {
    var articleId = req.params.id;
    Article.findByIdAndRemove(articleId, function (err, article) {
        User.reduceArticleCount(article.creator, function (err) {
            res.redirect("/");
        });
    });
};

exports.output = function (req, res) {
    var inList = false,
        enListHTML = "",
        cnListHTML = "";
    Article.findById(req.params.id, function (err, data) {
        var html, p, i;
        html = '';
        for (i = 0, _len = data.paraList.length; _i < _len; _i++) {
            p = data.paraList[i];
            switch (req.params.mode) {
                case 'en':
                    if (p.type === 'list') {
                        if (!inList) {
                            inList = true;
                            enListHTML = "";
                        }
                        enListHTML += outputHTML(p.type, p.en) + "\n";
                    } else {
                        if (inList) {
                            inList = false;
                            html += "<ul>\n" + enListHTML + "</ul>";
                            html += "\n\n";
                        }
                        html += outputHTML(p.type, p.en);
                        html += "\n\n";
                    }
                    break;
                case 'cn':
                    if (p.type === 'list') {
                        if (!inList) {
                            inList = true;
                            cnListHTML = "";
                        }
                        cnListHTML += outputHTML(p.type, p.cn) + "\n";
                    } else {
                        if (inList) {
                            inList = false;
                            html += "<ul>\n" + cnListHTML + "</ul>";
                            html += "\n\n";
                        }
                        html += outputHTML(p.type, p.cn);
                        html += "\n\n";
                    }
                    break;
                case 'ec':
                    if (p.type === 'list') {
                        if (!inList) {
                            inList = true;
                            enListHTML = "";
                            cnListHTML = "";
                        }
                        enListHTML += outputHTML(p.type, p.en) + "\n";
                        cnListHTML += outputHTML(p.type, p.cn) + "\n";
                    } else {
                        if (inList) {
                            inList = false;
                            html += "<ul>\n" + enListHTML + "</ul>";
                            html += "\n";
                            html += "<ul>\n" + cnListHTML + "</ul>";
                            html += "\n\n";
                        }
                        html += outputHTML(p.type, p.en);
                        html += "\n";
                        html += outputHTML(p.type, p.cn);
                        html += "\n\n";
                    }
                    break;
            }
        }
        res.set('Content-Type', 'text/plain;charset=utf-8');
        return res.send(200, html);
    });
};

/*
 * Output html
 * @params {String} type - the type of para
 * @params
 */
function outputHTML(type, content) {
    var html;
    switch (type) {
        case 'header':
            html = "<h3>" + content + "</h3>";
            break;
        case 'text':
            html = "<p>" + content + "</p>";
            break;
        case 'image':
            html = "<p><img src='" + content + "' /></p>";
            break;
        case 'quote':
            html = "<blockquote>" + content + "</blockquote>";
            break;
        case 'list':
            html = "<li>" + content + "</li>";
            break;
    }
    return html;
};