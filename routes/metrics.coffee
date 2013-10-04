# Handles POSTs from the Meducation server metrics handler

exports.traffic = (request, response) ->

  for metric, value of request.body
    console.log "received: #{metric}:#{value}"

  response.send 200