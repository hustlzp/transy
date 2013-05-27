var site = require('./controllers/site');
var article = require('./controllers/article');

module.exports = function(app){
  /* site */
  // home page
  app.get('/', site.index);

  /* article */
  // new
  app.get('/article/add', article.showAdd);
  app.post('/article/add', article.add);
  // edit
  app.get('/article/edit/:id', article.showEdit);
  app.get('/article/edit/:id', article.edit);
  // single article
  app.get('/article/:id', article.article);
}
