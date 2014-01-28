/*
 * Route Rules
 */

var validator = require('./validator'),
    site = require('./controllers/site'),
    sign = require('./controllers/sign'),
    user = require('./controllers/user'),
    article = require('./controllers/article'),
    topic = require('./controllers/topic');

/*
 * Apply route rules to app object
 * @param {app object} app - the app
 */

module.exports = function (app) {
    // Site
    app.get('/', site.index);
    app.get('/about', site.about);

    // Account
    app.get('/signup', sign.showSignup);
    app.post('/signup', validator.signup, sign.signup);
    app.get('/signin', sign.showSignin);
    app.post('/signin', validator.signin, sign.signin);
    app.get('/signout', sign.signout);

    // Article
    app.get('/article/add', article.showAdd);
    app.post('/article/add', validator.article, article.add);
    app.get('/article/:id/edit', article.showEdit);
    app.post('/article/:id/edit', article.edit);
    app.get('/article/:id/delete', article["delete"]);
    app.get('/article/:id/output/:mode', article.output);
    app.post('/article/:id/comment', article.comment);
    app.get('/comment/:id/remove', article.discomment);
    app.get('/article/:id/collect', article.collect);
    app.get('/article/:id/discollect', article.discollect);
    app.get('/article/:id', article.article);

    /*
    // Topic
    app.get('/topic/add', topic.showAdd);
    app.post('/topic/add', validator.topic, topic.add);
    app.get('/topic/:id/edit', topic.showEdit);
    app.post('/topic/:id/edit', validator.topic, topic.edit);
    app.get('/topic/:id/delete', topic["delete"]);
    app.get('/topic/:id', topic.topic);
    app.get('/topics', topic.topics);
    */

    // User
    app.get('/u/setting', user.showSetting);
    app.post('/u/setting', validator.setting, user.setting);
    app.get('/u/:user', user.articles);
    app.get('/u/:user/collects', user.collects);
    app.get('/u/:user/comments', user.comments);
};