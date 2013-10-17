# Handles POSTs from the Meducation server metrics handler

exports.traffic = (request, response) ->

  console.log "***HEADERS*** #{request.headers}"
  console.log "***BODY*** #{request.body}"

  for metric, value of request.body
    console.log "received: #{metric}:#{value}"

  request.io.broadcast 'metric',
    metrics:
      anon: request.body.anon,
      normal: request.body.normal,
      premium: request.body.premium

  response.send 200

exports.events = (request, response) ->
  console.log request.body

  response.send 200