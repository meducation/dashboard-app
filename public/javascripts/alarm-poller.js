(function() {
  var alarmsFailTemplate, alarmsOKTemplate, compileTemplate, pollingTimeInMilliseconds;

  compileTemplate = function(templateSelector) {
    var source, template;
    source = $(templateSelector).html();
    template = Handlebars.compile(source);
    return template;
  };

  alarmsFailTemplate = compileTemplate('#alarms-fail-template');

  alarmsOKTemplate = compileTemplate('#alarms-ok-template');

  pollingTimeInMilliseconds = 10000;

  setInterval(function() {
    return $.get('http://pergo.meducation.net:4567', function(alarmsData) {
      var $alarms, parsedAlarmsData;
      $alarms = $('.alarms');
      parsedAlarmsData = JSON.parse(alarmsData);
      if (parsedAlarmsData.alarms.length > 0) {
        return $alarms.html(alarmsFailTemplate(parsedAlarmsData));
      } else {
        return $alarms.html(alarmsOKTemplate());
      }
    });
  }, pollingTimeInMilliseconds);

}).call(this);

/*
//@ sourceMappingURL=alarm-poller.js.map
*/