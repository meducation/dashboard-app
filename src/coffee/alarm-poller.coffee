compileTemplate = (templateSelector) ->
  source = $(templateSelector).html()
  template = Handlebars.compile source
  template

alarmsFailTemplate = compileTemplate '#alarms-fail-template'
alarmsOKTemplate = compileTemplate '#alarms-ok-template'

pollingTimeInMilliseconds = 10000

setInterval ->
  $.get 'http://pergo.meducation.net:4567', (alarmsData) ->
    $alarms = $('.alarms')
    parsedAlarmsData = JSON.parse(alarmsData)

    if parsedAlarmsData.alarms.length > 0
      $alarms.html alarmsFailTemplate parsedAlarmsData
    else
      $alarms.html alarmsOKTemplate()

, pollingTimeInMilliseconds