# Module dependencies.

express = require 'express'
routes = require './routes'
metrics = require './routes/metrics'
http = require 'http'
path = require 'path'
socketIO = require 'socket.io'

app = express()

# All environments.

app.set 'port', process.env.PORT || 3000
app.set 'views', __dirname + '/views'
app.use express.favicon()
app.use express.logger('dev')
app.use express.bodyParser()
app.use express.methodOverride()
app.use app.router
app.use express.static path.join __dirname, 'public'

# Development only.

if app.get 'env' is 'development'
  app.use express.errorHandler()

app.get '/', routes.index
app.post('/metrics/traffic', metrics.traffic);
#TODO (for receiving page views): app.post('/events', metrics.events);

server = http.createServer app
io = socketIO.listen server
port = app.get 'port'
server.listen port, ->
  console.log "Express server listening on port #{port}"

io.sockets.on 'connection', (socket) ->
  setInterval ->
    socket.emit 'metric',
      metrics:
        anon: Math.floor((Math.random() * 10000) + 1),
        normal: Math.floor((Math.random() * 1000) + 1),
        premium: Math.floor((Math.random() * 100) + 1)
  , 1000
