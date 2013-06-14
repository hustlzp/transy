###
Sign
###

User = require('../models/user')

# signup page
exports.showSignup = (req, res)->
  res.render('sign/signup')

# signup
exports.signup = (req, res)->
  if req.form.isValid
    # check if username exist
    User.find { name: req.form.name }, (err, data)->
      if data.length != 0
        req.form.errors.push('用户名已存在')
        res.render('sign/signup', { form: req.form })
      else
        # check if email exist
        User.find { email: req.form.email }, (err, data)->
          if data.length != 0
            req.form.errors.push('邮箱已存在')
            res.render('sign/signup', { form: req.form })
          else
            # add user
            user = new User()
            user.name = req.form.name
            user.email = req.form.email
            user.pwd = req.form.pwd
            user.isActive = false
            user.save (err)->
              res.cookie('username', req.form.name, { maxAge: 1000*3600*24*7 })
              res.redirect('/')
            # res.render 'message',
            #   header: 'Success'
            #   text: '欢迎加入Transy！激活链接已发送到您的注册邮箱，请登陆邮箱完成激活。'
  else
    res.render('sign/signup', { form: req.form })

# signin page
exports.showSignin = (req, res)->
  res.render('sign/signin')

# signin
exports.signin = (req, res)->
  if req.form.isValid
    # check if username exist
    User.find { email: req.form.email }, (err, data)->
      if data.length == 0
        req.form.errors.push('帐号不存在')
        res.render('sign/signin', { form: req.form })
      else
        # check if password is correct
        User
        .findOne({ email: req.form.email })
        .where('pwd').equals(req.form.pwd)
        .exec (err, data)->
          if data.length == 0
            req.form.errors.push('密码错误')
            res.render('sign/signin', { form: req.form })
          else
            # set session
            res.cookie('username', data.name, { maxAge: 1000*3600*24*7 })
            res.redirect('/')
  else
    res.render('sign/signin', { form: req.form })

# signout
exports.signout = (req, res)->
  res.clearCookie('username')
  res.redirect('/')
