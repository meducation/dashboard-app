# Module dependencies.

pkg = require './package.json'
express = require 'express.io'
routes = require './routes'
metrics = require './routes/metrics'
events = require './routes/events'
http = require 'http'
path = require 'path'

app = express()

# All environments.

app.set 'port', process.env.PORT || 3000
app.set 'views', __dirname + '/views'
app.use express.favicon()
app.use express.logger('dev')

# Use a raw body parser to handle SNS messages
# They are received as plain/text.

app.use (request, response, next) ->
  request.rawBody = ''
  request.setEncoding 'utf8'

  request.on 'data', (chunk) ->
    request.rawBody += chunk

  request.on 'end', () ->
    console.log """Received headers:
      #{JSON.stringify request.headers}"""
    console.log """Received raw body:
      #{request.rawBody}"""
    next()

app.use express.methodOverride()
app.use '/', express.static path.join __dirname, 'public'
app.use '/src', express.static path.join __dirname, 'src'

# Development only.

if app.get 'env' is 'development'
  app.use express.errorHandler()

app.http().io()

# Respond to client requests for the latest version

app.io.route 'version', (request) ->
  request.io.respond { version: pkg.version }

app.get '/', routes.index
app.post '/metrics/traffic', metrics.traffic
app.post '/events', events.events

port = app.get 'port'
app.listen port, ->
  console.log "Express server listening on port #{port}"
