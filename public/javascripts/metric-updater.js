(function() {
  var compileTemplate, metricBlockTemplate, metricData, socket, testTubesTemplate, updateIfVersionChanges, versionTemplate;

  compileTemplate = function(templateSelector) {
    var source, template;
    source = $(templateSelector).html();
    template = Handlebars.compile(source);
    return template;
  };

  versionTemplate = compileTemplate('#version-template');

  metricBlockTemplate = compileTemplate('#metric-block-template');

  testTubesTemplate = compileTemplate('#test-tube-template');

  updateIfVersionChanges = function() {
    var currentVersion, intervalCheckInMilliseconds;
    currentVersion = null;
    intervalCheckInMilliseconds = 1000 * 60;
    socket.emit('version', {}, function(response) {
      currentVersion = response.version;
      return $('.version').replaceWith(versionTemplate(response));
    });
    return setInterval(function() {
      return socket.emit('version', {}, function(response) {
        if (response.version !== currentVersion) {
          return location.reload();
        }
      });
    }, intervalCheckInMilliseconds);
  };

  metricData = {
    metrics: {
      anon: {
        colour: 'orange',
        number: '...',
        title: 'Anonymous Visitors'
      },
      normal: {
        colour: 'blue',
        number: '...',
        title: 'Logged-in Visitors'
      },
      premium: {
        colour: 'green',
        number: '...',
        title: 'Premium Visitors'
      }
    },
    tubes: {
      unique_loggedin_last_hour: {
        title: 'Last hour',
        number: '...'
      },
      unique_loggedin_last_day: {
        title: 'Last day',
        number: '...'
      },
      unique_loggedin_last_week: {
        title: 'Last week',
        number: '...'
      },
      unique_loggedin_last_month: {
        title: 'Last month',
        number: '...'
      }
    }
  };

  $('.metric-blocks').html(metricBlockTemplate(metricData));

  $('.test-tubes').html(testTubesTemplate(metricData));

  socket = io.connect("http://" + window.location.hostname);

  updateIfVersionChanges();

  socket.on('metric', function(payload) {
    var key;
    for (key in payload.metrics) {
      metricData.metrics[key].number = payload.metrics[key];
    }
    for (key in payload.tubes) {
      metricData.tubes[key].number = payload.tubes[key];
    }
    $('.metric-blocks').html(metricBlockTemplate(metricData));
    return $('.test-tubes').html(testTubesTemplate(metricData));
  });

  socket.on('event', function(payload) {
    return console.log(payload);
  });

}).call(this);

/*
//@ sourceMappingURL=metric-updater.js.map
*/