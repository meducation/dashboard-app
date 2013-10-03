# GET home page.

exports.index = (request, response) ->
  response.sendfile 'views/index.html'