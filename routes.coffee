###
Route Rules
###

# Form Validator
validator = require('./validator')

# Controller
site = require('./controllers/site')
sign = require('./controllers/sign')
user = require('./controllers/user')
article = require('./controllers/article')
collection = require('./controllers/collection')

###
Apply route rules to app object
@param {app object} app - the app
###
module.exports = (app)->
  # site
  # home page
  app.get('/', site.index)

  # sign
  # signup
  app.get('/signup', sign.showSignup)
  app.post('/signup', validator.signup, sign.signup)
  # signin
  app.get('/signin', sign.showSignin)
  app.post('/signin', validator.signin, sign.signin)
  # signout
  app.get('/signout', sign.signout)
  # active

  # article
  # new
  app.get('/article/add/:cid', article.showAdd)
  app.post('/article/add/:cid', validator.addArticle, article.add)
  # edit
  app.get('/article/:id/edit', article.showEdit)
  app.post('/article/:id/edit', article.edit)
  # delete
  app.get('/article/:id/delete', article.delete)
  # output
  app.get('/article/:id/output/:mode', article.output)
  # single article
  app.get('/article/:id', article.article)


  # collection
  # add
  app.get('/collection/add', collection.showAdd)
  app.post('/collection/add', validator.addCollection, collection.add)
  # edit
  app.get('/collection/:id/edit', collection.edit)
  app.post('/collection/:id/edit', validator.addCollection, collection.edit)
  # delete
  app.get('/collection/:id/delete', collection.delete)
  # single collection
  app.get('/collection/:id', collection.collection)
  # collections
  app.get('/collections', collection.collections)

  # user
  # personal page
  app.get('/u/:user', user.articles)
  # loves
  app.get('/u/:user/love', user.love)
  # collections
  app.get('/u/:user/collections', user.collections)

