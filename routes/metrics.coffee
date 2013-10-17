# Handles POSTs from the Meducation server metrics handler (via Amazon SNS)

exports.traffic = (request, response) ->

  json = JSON.parse request.rawBody
  message = JSON.parse json.Message

  request.io.broadcast 'metric',
    metrics:
      anon: message.anon
      normal: message.normal
      premium: message.premium
    tubes:
      unique_loggedin_last_hour: message.unique_loggedin_last_hour
      unique_loggedin_last_day: message.unique_loggedin_last_day
      unique_loggedin_last_week: message.unique_loggedin_last_week
      unique_loggedin_last_month: message.unique_loggedin_last_month

  response.send 200
