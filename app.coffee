# Module dependencies.

express = require 'express.io'
routes = require './routes'
metrics = require './routes/metrics'
http = require 'http'
path = require 'path'

app = express()

# All environments.

app.set 'port', process.env.PORT || 3000
app.set 'views', __dirname + '/views'
app.use express.favicon()
app.use express.logger('dev')
app.use express.bodyParser()
app.use express.methodOverride()
app.use express.static path.join __dirname, 'public'

# Development only.

if app.get 'env' is 'development'
  app.use express.errorHandler()

app.http().io()

app.get '/', routes.index
app.post('/metrics/traffic', metrics.traffic);
app.post('/events', metrics.events);

port = app.get 'port'
app.listen port, ->
  console.log "Express server listening on port #{port}"
