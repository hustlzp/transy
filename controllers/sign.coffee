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
    res.send('yes')
  else
    res.render('sign/signup',
      form: req.form
    )

# signin page
exports.showSignin = (req, res)->
  res.render('sign/signin')

# signin
exports.signin = (req, res)->
  if req.form.isValid
    res.send('yes')
  else
    res.render('sign/signin',
      form: req.form
    )

# signout
exports.signout = (req, res)->
  res.send('')
