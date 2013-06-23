###
Form Validator
###

form = require('express-form')
field = form.field

# signin form validator
exports.signin = form(
  field('email', '邮箱').trim().required().isEmail(),
  field('pwd', '密码').trim().required()
)

# signup form validator
exports.signup = form(
  field('email', '邮箱').trim().required().isEmail(),
  field('name', '用户名').trim().required(),
  field('pwd', '密码').trim().required(),
  field('repwd', '重复密码').trim().required().equals('field::pwd', '两次输入密码不一致')
)

# article form validator
exports.article = form(
  field('title', '标题').trim().required(),
  field('author', '作者').trim().required(),
  field('url', '链接').trim().required().isUrl(),
  field('content', '正文').trim().required()
)

# topic form validator
exports.topic = form(
  field('type', '类别').trim(),
  field('title', '标题').trim().required(),
  field('intro', '描述').trim().required(),
  field('image', '图片').trim()
)