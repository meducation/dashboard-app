compileTemplate = (templateSelector) ->
  source = $(templateSelector).html()
  template = Handlebars.compile source
  template

metricData =
  metrics:
    anon:
      colour: 'orange', number: '...', title: 'Anonymous Visitors'
    ,
    normal:
      colour: 'blue', number: '...', title: 'Logged-in Visitors'
    ,
    premium:
      colour: 'green', number: '...', title: 'Premium Visitors'
  tubes:
    unique_loggedin_last_hour:
      title: 'Last hour', number: '...'
    unique_loggedin_last_day:
      title: 'Last day', number: '...'
    unique_loggedin_last_week:
      title: 'Last week', number: '...'
    unique_loggedin_last_month:
      title: 'Last month', number: '...'

metricBlockTemplate = compileTemplate '#metric-block-template'
$('.metric-blocks').html metricBlockTemplate(metricData)

testTubesTemplate = compileTemplate '#test-tube-template'
$('.test-tubes').html testTubesTemplate(metricData)

socket = io.connect "http://#{window.location.hostname}"
socket.emit 'ready'

socket.on 'metric', (payload) ->
  for key of payload.metrics
    metricData.metrics[key].number = payload.metrics[key]
  for key of payload.tubes
    metricData.tubes[key].number = payload.tubes[key]

  $('.metric-blocks').html metricBlockTemplate(metricData)
  $('.test-tubes').html testTubesTemplate(metricData)

socket.on 'event', (payload) ->
  console.log payload