
###
App File
###
  
express = require('express')
routes = require('./routes')
http = require('http')
path = require('path')

# app
app = express()

# db
mongoose = require('mongoose')
option =
  server: { keepAlive: 1 }
  replset: { keepAlive: 1 }
mongoose.connect('mongodb://localhost:27017/transy')

# all environments
app.set('port', process.env.PORT || 3000)
app.set('ip', '127.0.0.1')
app.set('views', __dirname + '/views')
app.set('view engine', 'jade')
app.use(express.favicon())
app.use(express.logger('dev'))
app.use(express.bodyParser())
app.use(express.methodOverride())
app.use(app.router)
app.use(express.static(path.join(__dirname, 'static')))

# development only
if 'development' == app.get('env')
  app.use(express.errorHandler())

# apply route rules
routes(app)

http.createServer(app).listen(app.get('port'), app.get('ip'), 511, ->
  console.log('Express server listening on ' + app.get('ip') + ':' + app.get('port'))
)
