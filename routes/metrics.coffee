# Handles POSTs from the Meducation server metrics handler

exports.traffic = (request, response) ->

  json = JSON.parse request.rawBody
  message = JSON.parse json.Message

  request.io.broadcast 'metric',
    metrics:
      anon: message.anon,
      normal: message.normal,
      premium: message.premium

  response.send 200

exports.events = (request, response) ->
  console.log request.body

  response.send 200