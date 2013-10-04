(function() {
  var data, socket, source, template;

  data = {
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
    }
  };

  source = $('#metric-block-template').html();

  template = Handlebars.compile(source);

  $('.metric-channel-blocks').html(template(data));

  socket = io.connect("http://" + window.location.hostname);

  socket.emit('ready');

  socket.on('metric', function(payload) {
    var key;
    for (key in payload.metrics) {
      data.metrics[key].number = payload.metrics[key];
    }
    return $('.metric-channel-blocks').html(template(data));
  });

}).call(this);

/*
//@ sourceMappingURL=metric-updater.js.map
*/