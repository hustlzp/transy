###
Route Rules
###

site = require('./controllers/site')
article = require('./controllers/article')

###
Apply route rules to app object
@param {app object} app - the app
###
module.exports = (app)->
  # site
  # home page
  app.get('/', site.index)

  # article
  # new
  app.get('/article/add', article.showAdd)
  app.post('/article/add', article.add)
  # edit
  app.get('/article/:id/edit', article.showEdit)
  app.post('/article/:id/edit', article.edit)
  # delete
  # app.get('/article/:id/delete', article.delete)
  # output
  app.get('/article/:id/output/:mode', article.output)
    # single article
  app.get('/article/:id', article.article)