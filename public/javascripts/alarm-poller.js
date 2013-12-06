(function() {
  var alarmsTemplate, compileTemplate, pollingTimeInMilliseconds;

  compileTemplate = function(templateSelector) {
    var source, template;
    source = $(templateSelector).html();
    template = Handlebars.compile(source);
    return template;
  };

  alarmsTemplate = compileTemplate('#alarms-template');

  pollingTimeInMilliseconds = 60000;

  setInterval(function() {
    return $.get('http://pergo.meducation.net:4567', function(alarmsData) {
      return $('.alarms').html(alarmsTemplate(JSON.parse(alarmsData)));
    });
  }, pollingTimeInMilliseconds);

}).call(this);

/*
//@ sourceMappingURL=alarm-poller.js.map
*/