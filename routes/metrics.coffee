# Handles POSTs from the Meducation server metrics handler

exports.traffic = (request, response) ->

  for metric, value of request.body
    console.log "received: #{metric}:#{value}"

  request.io.broadcast 'metric',
    metrics:
      anon: request.body.anon,
      normal: request.body.normal,
      premium: request.body.premium

  response.send 200

exports.events = (request, response) ->

  for key, value of request.body
    console.log "received: #{key}:#{value}"

  response.send 200