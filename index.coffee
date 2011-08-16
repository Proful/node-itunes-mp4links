request = require("request")
jsdom = require("jsdom")

uri = process.argv[2]
console.log "URL: " + uri

request {uri: uri}, (error,response,body)->
  if error and response.statusCode not 200
    console.log "Error retrieving #{uri}"

  jsdom.env {
    html:body,
    scripts:[
      'http://code.jquery.com/jquery-1.5.min.js'
    ]
  }, (err,window) ->
    $ = window.jQuery

    $('tr.podcast-episode').each ()->
      console.log $(this).attr('video-preview-url')
