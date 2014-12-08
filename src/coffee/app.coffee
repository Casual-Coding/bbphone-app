define (require) ->
  Marionette = require("marionette")
  Channel = require("channel")
  require("router")
  require("ui/range")

  App = new Marionette.Application

  App.addRegions
    titlebar: "#titlebar"
    content: "#content"

  App.on "start", (options) ->
    App.isCordova = options.isCordova
    Channel.execute("router:init")
    Backbone.history.start() if Backbone.history

  Channel.connectCommands
    "view:show": (view) =>
      App.content.show(view)
    "titlebar:show": (view) =>
      App.titlebar.$el.addClass("has-content")
      App.titlebar.show(view)
    "titlebar:empty": (view) =>
      App.titlebar.$el.removeClass("has-content")
      App.titlebar.empty()

  Channel.connectRequests
    "app": -> App

  App