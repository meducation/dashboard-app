# Handles events POSTed from the Meducation server (via Amazon SNS)

exports.events = (request, response) ->

  json = JSON.parse request.rawBody
  message = JSON.parse json.Message

  request.io.broadcast 'event',
    event: message

  response.send 200