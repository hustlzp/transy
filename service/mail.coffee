###
Mail Service
###

nodemailer = require("nodemailer")
config = require('../config')

###
Send Mail by nodemailer
@method sendMail
@params {String} to - Email address to send to
@params {String} subject - Email subject
@params {String} html -Email content
###
sendMail = (to, subject, html)->
  smtpTransport = nodemailer.createTransport("SMTP", config.mailOptions)

  mail = 
    from: "Transy <#{config.mailOptions.auth.user}>"
    to: to
    subject: subject
    html: html

  smtpTransport.sendMail(mail, (err)->
    if err
      console.log(err)
    else
      console.log('ok')
  )


###
Send active email
@method sendActiveEmail
@params {String} to - Email address to send to
@params {String} name - name of the user
@params {String} token - active token
###
exports.sendActiveMail = (to, name, token)->
  subject = 'Transy帐号激活'
  html = """
    <p>您好：<p/>
    <p>我们收到您在Transy的注册信息，请点击下面的链接来激活帐户：</p>
    <a href="#{config.host}/active_account?token=#{token}&name=#{name}">激活链接</a>
    <p>若您没有在Transy填写过注册信息，说明有人滥用了您的电子邮箱，请删除此邮件，我们对给您造成的打扰感到抱歉。</p>
  """
  sendMail(to, subject, html)