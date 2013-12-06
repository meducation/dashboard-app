compileTemplate = (templateSelector) ->
  source = $(templateSelector).html()
  template = Handlebars.compile source
  template

alarmsTemplate = compileTemplate '#alarms-template'

pollingTimeInMilliseconds = 60000

setInterval ->
  $.get 'http://pergo.meducation.net:4567', (alarmsData) ->
    $('.alarms').html alarmsTemplate JSON.parse(alarmsData)
, pollingTimeInMilliseconds