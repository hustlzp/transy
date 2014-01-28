/**
 * Route Rules
 */

var validator = require('./validator'),
    site = require('./controllers/site'),
    account = require('./controllers/account'),
    user = require('./controllers/user'),
    article = require('./controllers/article');

/*
 * Apply route rules to app object
 * @param {app object} app - the app
 */
module.exports = function (app) {
    // Site
    app.get('/', site.index);
    app.get('/about', site.about);

    // Account
    app.get('/signup', account.showSignup);
    app.post('/signup', validator.signup, account.signup);
    app.get('/signin', account.showSignin);
    app.post('/signin', validator.signin, account.signin);
    app.get('/signout', account.signout);

    // Article
    app.get('/article/add', article.showAdd);
    app.post('/article/add', validator.article, article.add);
    app.get('/article/:id/edit', article.showEdit);
    app.post('/article/:id/edit', article.edit);
    app.get('/article/:id/delete', article["delete"]);
    app.get('/article/:id/output/:mode', article.output);
    app.get('/article/:id', article.article);

    // User
    app.get('/u/setting', user.showSetting);
    app.post('/u/setting', validator.setting, user.setting);
};