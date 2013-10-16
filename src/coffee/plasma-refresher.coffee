refreshIntervalInMilliSeconds = 5 * 60 * 1000

setInterval( ->
  $('.fader').toggleClass 'fade-to-black'
  setTimeout( ->
    $('.fader').toggleClass 'fade-back'
  , 2000)
, refreshIntervalInMilliSeconds)