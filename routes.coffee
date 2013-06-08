###
Route Rules
###

# Form Validator
validator = require('./validator')

# Controller
site = require('./controllers/site')
article = require('./controllers/article')
sign = require('./controllers/sign')

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
  # app.get('/article/:id/delete', article.delete)
  # output
  app.get('/article/:id/output/:mode', article.output)
    # single article
  app.get('/article/:id', article.article)


