###
Form Validator
###

form = require('express-form')
field = form.field

# signin form validator
exports.signinForm = form(
  field('email', '邮箱').trim().required().isEmail(),
  field('pwd', '密码').trim().required()
)

# signup form validator
exports.signupForm = form(
  field('email', '邮箱').trim().required().isEmail(),
  field('name', '用户名').trim().required(),
  field('pwd', '密码').trim().required(),
  field('repwd', '重复密码').trim().required().equals('field::pwd', '两次输入密码不一致')
)

# add article form validator
exports.addArticleForm = form(
  field('title', '标题').trim().required(),
  field('author', '作者').trim().required(),
  field('url', '链接').trim().required().isUrl(),
  field('content', '正文').trim().required()
)
