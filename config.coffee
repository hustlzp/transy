###
Config
###

module.exports =
  # site
  host: 'http://localhost:3000'

  # smtp mail options
  mailOptions:
    host: 'smtp.126.com',
    port: 465,
    secureConnection: true,
    auth:
      user: "transy@126.com",
      pass: "transy2013"