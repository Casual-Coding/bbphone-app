define (require) ->
  Marionette = require("marionette")
  LayoutView = require("components/threads/views/layoutView")
  TitlebarView = require("components/threads/views/titlebarView")
  Channel = require("channel")

  require("entities/thread")

  class ThreadsController extends Marionette.Controller
    initialize: ->
      @channel = Channel.request("channel")

      @_setEventHandlers()

    detail: (id, page) ->
      promise = Channel.request("entity:thread", id, page: page)
      promise.then (thread) =>
        Channel.execute("view:show", new LayoutView
          model: thread
          channel: @channel
        )
        Channel.execute("titlebar:show", new TitlebarView
          model: thread)

      Channel.execute("view:show", new LayoutView)
      Channel.execute("titlebar:show", new TitlebarView)

    onDestroy: ->
      @channel.reset()

    _onLinkClick: (url) =>
      if match = url.match(/forum\.mods\.de\/bb\/(board|thread|tagged-thread)\.php\?(BID|TID)\=(\d+)(\&page\=(\d+))?/)

        if match[5] is "page"
          page = match[6]
        else
          page = 1

        switch match[1]
          when "thread"
            Channel.execute("router:navigate", "thread/#{match[3]}/#{page}")
          when "board"
            Channel.execute("router:navigate", "board/#{match[3]}/#{page}")
          when "tagged-thread"
            $.get url, (response) ->
              if match = response.match(/\?TID=(\d+)/)
                Channel.execute("router:navigate", "thread/#{match[1]}/1")
              else
                console.log "Invalid internal link"
          else
            console.log "Invalid internal link"
      else
        window.open(url, "_blank")

    _setEventHandlers: ->
      @channel.connectEvents
        "link:click": @_onLinkClick


  controller = new ThreadsController

  Channel.connectCommands
    "thread:detail": (id, page) ->
      controller.detail(id, page)
