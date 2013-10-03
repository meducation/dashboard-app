var data = {
    metrics: {
        anon: { colour: 'orange', number: 'loading...', title: 'Anonymous Visitors' },
        normal: { colour: 'blue', number: 'loading...', title: 'Normal Visitors' },
        premium: { colour: 'green', number: 'loading...', title: 'Premium Visitors' }
    }
}
var source   = $("#metric-block-template").html();
var template = Handlebars.compile(source);
$('.metric-channel-blocks').html(template(data));

var socket = io.connect('http://' + window.location.hostname);

socket.on('metric', function (payload) {
    for(key in payload.metrics) {
        data.metrics[key].number = payload.metrics[key];
    }
    $('.metric-channel-blocks').html(template(data));
});