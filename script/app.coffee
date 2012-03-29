pageinit = ->
  #LazyLoad.css ['https://raw.github.com/needim/noty/master/css/jquery.noty.css','https://raw.github.com/needim/noty/master/css/noty_theme_default.css']
  #LazyLoad.js ['http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js', 'https://raw.github.com/needim/noty/master/js/jquery.noty.js'], ->

  LazyLoad.css 'https://raw.github.com/wavded/humane-js/master/themes/jackedup.css'
  LazyLoad.js 'https://raw.github.com/wavded/humane-js/master/humane.min.js', ->
    info = (message) ->
      Notification.info message

    error = (message) ->
      Notification.error message

    success = (message) ->
      Notification.success message

    #jQuery.noConflict()
    htmlEscape = (str) ->
      String(str).replace(/&/g, "&amp;").replace(/"/g, "&quot;").replace(/'/g, "&#39;").replace(/</g, "&lt;").replace />/g, "&gt;"
    window.h = new HuluVideo
    if !h.is_video or !h.has_cid
      console.log 'not hulu'
      error 'Oops - this is not a valid Hulu video page...'
    else
      h.bind 'change:subtitles', ->
        console.log('subs loaded')
        info 'Subtitles loaded successfully - parsing for profanity...'
      h.bind 'change:blocklist', ->
        console.log('subs processed')
        success 'Success!  Your video is filtered...'
        muter = new Muter(h.blocklist)
        muter.rebuild()
        muter.startRebuildTesting()
        window.muter = muter
      h.load_subtitles()


if document.readyState is "complete"
  window.setTimeout(pageinit, 1000)
else if window.addEventListener
    window.addEventListener 'load', pageinit, false

