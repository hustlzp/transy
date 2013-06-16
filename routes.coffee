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
  app.post('/signup', validator.signupForm, sign.signup)
  # signin
  app.get('/signin', sign.showSignin)
  app.post('/signin', validator.signinForm, sign.signin)
  # signout
  app.get('/signout', sign.signout)
  # active

  # article
  # new
  app.get('/article/add', article.showAdd)
  app.post('/article/add', validator.addArticleForm, article.add)
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
  # collections
  app.get('/collections', collection.collections)

  # user
  # personal page
  app.get('/me', user.me)
  # loves
  app.get('/my/love', user.love)
  #collections
  app.get('/my/collections', user.collections)

