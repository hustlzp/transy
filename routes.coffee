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
topic = require('./controllers/topic')

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
  # todo

  # article
  # new
  app.get('/article/add/:tid', article.showAdd)
  app.post('/article/add/:tid', validator.article, article.add)
  # edit
  app.get('/article/:id/edit', article.showEdit)
  app.post('/article/:id/edit', article.edit)
  # delete
  app.get('/article/:id/delete', article.delete)
  # output
  app.get('/article/:id/output/:mode', article.output)
  # comment & discomment
  app.post('/article/:id/comment', article.comment)
  app.get('/comment/:id/remove', article.discomment)
  # collect & discollect
  app.get('/article/:id/collect', article.collect)
  app.get('/article/:id/discollect', article.discollect)
  # single article
  app.get('/article/:id', article.article)


  # topic
  # add
  app.get('/topic/add', topic.showAdd)
  app.post('/topic/add', validator.topic, topic.add)
  # edit
  app.get('/topic/:id/edit', topic.edit)
  app.post('/topic/:id/edit', validator.topic, topic.edit)
  # delete
  app.get('/topic/:id/delete', topic.delete)
  # single topic
  app.get('/topic/:id', topic.topic)
  # collections
  app.get('/topics', topic.topics)

  # user
  # user setting
  app.get('/u/setting', user.setting)
  # personal page
  app.get('/u/:user', user.articles)
  # loves
  app.get('/u/:user/collect', user.collect)
  # collections
  app.get('/u/:user/topics', user.topics)
