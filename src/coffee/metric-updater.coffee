data =
  metrics:
    anon:
      colour: 'orange', number: '...', title: 'Anonymous Visitors'
    ,
    normal:
      colour: 'blue', number: '...', title: 'Logged-in Visitors'
    ,
    premium:
      colour: 'green', number: '...', title: 'Premium Visitors'

source = $('#metric-block-template').html()
template = Handlebars.compile source
$('.metric-channel-blocks').html template(data)

socket = io.connect "http://#{window.location.hostname}"
socket.emit 'ready'
socket.on 'metric', (payload) ->
  for key of payload.metrics
    data.metrics[key].number = payload.metrics[key]

  $('.metric-channel-blocks').html template(data)
