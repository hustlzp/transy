###
Sign Controller
###


User = require('../models/user')
mail = require('../service/mail')
mongoose = require('mongoose')
ObjectId = mongoose.Types.ObjectId

# signup page
exports.showSignup = (req, res)->
  res.render('sign/signup')

# signup
exports.signup = (req, res, next)->
  if req.form.isValid
    # check if username exist
    User.getByName req.form.name, (err, user)->
      if user
        req.form.pushError('name', '用户名已存在')
        res.render('sign/signup', { form: req.form })
      else
        # check if email exist
        User.getByEmail req.form.email, (err, user)->
          if user
            req.form.pushError('email', '邮箱已存在')
            res.render('sign/signup', { form: req.form })
          else
            # add user
            userId = new ObjectId()
            name = req.form.name
            email = req.form.email
            pwd = req.form.pwd
            User.add userId, name, email, pwd, (err)->
              gene_cookie(res, userId, name, email)
              res.redirect('/')
  else
    res.render('sign/signup', { form: req.form })

# active account
exports.activeAccount = (req, res)->
  res.send('active')

# signin page
exports.showSignin = (req, res)->
  res.render('sign/signin')

# signin
exports.signin = (req, res)->
  if req.form.isValid
    # check if username exist
    User.getByEmail req.form.email, (err, user)->
      if not user
        req.form.pushError('email', '帐号不存在')
        res.render('sign/signin', { form: req.form })
      else
        # check if password is correct
        User.getByEmailAndPwd req.form.email, req.form.pwd, (err, user)->
          if not user
            req.form.pushError('pwd', '密码错误')
            res.render('sign/signin', { form: req.form })
          else
            # set session
            gene_cookie(res, user.id, user.name, user.email)
            res.redirect('/')
  else
    res.render('sign/signin', { form: req.form })

# signout
exports.signout = (req, res)->
  res.clearCookie('user')
  res.redirect('/')

###
Generate cookie of user name, id, email for 7 days
@method gene_cookie
@params {Object} res - Response Object
@params {String} userId
@params {String} name
@params {String} email
###
gene_cookie = (res, userId, name, email)->
  res.cookie('user',
    'id': userId
    'name': name
    'email': email
  , { maxAge: 1000*3600*24*7 })

