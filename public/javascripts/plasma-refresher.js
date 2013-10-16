(function() {
  var refreshIntervalInMilliSeconds;

  refreshIntervalInMilliSeconds = 5 * 60 * 1000;

  setInterval(function() {
    $('.fader').toggleClass('fade-to-black');
    return setTimeout(function() {
      return $('.fader').toggleClass('fade-back');
    }, 2000);
  }, refreshIntervalInMilliSeconds);

}).call(this);

/*
//@ sourceMappingURL=plasma-refresher.js.map
*/