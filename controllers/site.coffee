###
Site Controller
###

nodemailer = require("nodemailer")
Article = require('../models/article')


exports.index = (req, res)->
  # create reusable transport method (opens pool of SMTP connections)
  smtpTransport = nodemailer.createTransport("SMTP",
    host: 'smtp.126.com',
    port: 465,
    secureConnection: true,
    auth:
      user: "transy@126.com",
      pass: "transy2013"
  )

  # setup e-mail data with unicode symbols
  mailOptions = 
    from: "Transy <transy@126.com>", # sender address
    to: "hustlzp@qq.com", # list of receivers
    subject: "Hello", # Subject line
    html: "<b>Hello world</b>" # html body

  # send mail with defined transport object
  smtpTransport.sendMail(mailOptions, (err) ->
    if err
      console.log(err)
    else
      console.log('ok')
  )

  Article
  .find({ completion: 100 })
  .populate('creator')
  .populate('topic')
  .exec (err, data)->
    res.render('index', { articles: data })
      