#Transy v2

http://www.transy.org

A Simple Wep App helps people translate English to Chinese.

Build with Node.js, MongoDB and Metro UI CSS.

##deploy

* Install the latest MongoDB (see [here](http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/)).
* Install packages: `npm install`.
* Install pm2: `npm install pm2@latest -g`.
* `pm2 start app.js -i 1`, for usage of pm2 see [here](https://github.com/Unitech/pm2).
* `cp nginx.conf /etc/nginx/sites-available/transy` and `nginx -s reload`
