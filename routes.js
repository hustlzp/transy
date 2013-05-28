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
  app.get('/article/:id/edit', article.showEdit);
  app.post('/article/:id/edit', article.edit);
  // delete
  app.get('/article/:id/delete', article.delete);
  // single article
  app.get('/article/:id', article.article);
}
