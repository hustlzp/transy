/*
 * Mail Service
 */

var nodemailer = require("nodemailer"),
    config = require('../config');

/*
 * Send active email
 * @method sendActiveEmail
 * @params {String} to - Email address to send to
 * @params {String} name - name of the user
 * @params {String} token - active token
 */
exports.sendActiveMail = function (to, name, token) {
    var html, subject;
    subject = 'Transy帐号激活';
    html = "<p>您好：<p/>\n<p>我们收到您在Transy的注册信息，请点击下面的链接来激活帐户：</p>\n<a href=\""
        + config.host + "/active_account?token=" + token + "&name=" + name +
        "\">激活链接</a>\n<p>若您没有在Transy填写过注册信息，说明有人滥用了您的电子邮箱，请删除此邮件，我们对给您造成的打扰感到抱歉。</p>";
    return sendMail(to, subject, html);
};

/*
 * Send Mail by nodemailer
 * @method sendMail
 * @params {String} to - Email address to send to
 * @params {String} subject - Email subject
 * @params {String} html -Email content
 */
function sendMail(to, subject, html) {
    var mail, smtpTransport;
    smtpTransport = nodemailer.createTransport("SMTP", config.mailOptions);
    mail = {
        from: "Transy <" + config.mailOptions.auth.user + ">",
        to: to,
        subject: subject,
        html: html
    };
    return smtpTransport.sendMail(mail, function (err) {
        if (err) {
            return console.log(err);
        } else {
            return console.log('ok');
        }
    });
};