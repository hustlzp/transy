var site = require('./controllers/site');
var article = require('./controllers/article');

module.exports = function(app){
  /* site */
  // home page
  app.get('/', site.index);

  /* article */
  // single article
  app.get('/article/:id', article.article);
}
