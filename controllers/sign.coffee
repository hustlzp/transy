###
Sign Controller
###

crypto = require('crypto')
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
    User.find { name: req.form.name }, (err, data)->
      if data.length != 0
        req.form.pushError('name', '用户名已存在')
        res.render('sign/signup', { form: req.form })
      else
        # check if email exist
        User.find { email: req.form.email }, (err, data)->
          if err
            return next(err)
          if data.length != 0
            req.form.pushError('email', '邮箱已存在')
            res.render('sign/signup', { form: req.form })
          else
            # add user
            user = new User()
            user._id = new ObjectId()
            user.name = req.form.name
            user.email = req.form.email
            user.pwd = md5(req.form.pwd)
            user.isActive = false
            user.save (err)->
              if err
                return next(err)
              gene_cookie(res, user)
              res.redirect('/')
  else
    res.render('sign/signup', { form: req.form })

# active account
exports.activeAccount = (req, res)->


# signin page
exports.showSignin = (req, res)->
  res.render('sign/signin')

# signin
exports.signin = (req, res)->
  if req.form.isValid
    # check if username exist
    User.find { email: req.form.email }, (err, data)->
      if err
        return next(err)
      if data.length == 0
        req.form.pushError('email', '帐号不存在')
        res.render('sign/signin', { form: req.form })
      else
        # check if password is correct
        User
        .findOne({ email: req.form.email })
        .where('pwd').equals(md5(req.form.pwd))
        .exec (err, user)->
          if err
            return next(err)
          if not user
            req.form.pushError('pwd', '密码错误')
            res.render('sign/signin', { form: req.form })
          else
            # set session
            gene_cookie(res, user)
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
@params {Object} user - User Object, contain name, id, email
###
gene_cookie = (res, user)->
  res.cookie('user',
    'id': user._id
    'name': user.name
    'email': user.email
  , { maxAge: 1000*3600*24*7 })

###
Get md5 value of a string
@method md5
@params {String} str - The string to be md5
@return {String} md5 value of the string
###
md5 = (str)->
  hash = crypto.createHash('md5')
  hash.update(str)
  hash.digest('hex')