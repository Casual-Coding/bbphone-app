define (require) ->
  Marionette = require("marionette")
  LayoutView = require("components/threads/views/layoutView")
  TitlebarView = require("components/threads/views/titlebarView")
  Channel = require("channel")

  require("entities/thread")

  class ThreadsController extends Marionette.Controller
    detail: (id) ->
      promise = Channel.request("entity:thread", id)
      promise.then (thread) ->
        Channel.execute("view:show", new LayoutView
          model: thread
        )
        Channel.execute("titlebar:show", new TitlebarView
          model: thread)
      .catch ->
        console.log arguments

      Channel.execute("view:show", new LayoutView)
      Channel.execute("titlebar:show", new TitlebarView)

  controller = new ThreadsController

  Channel.connectCommands
    "thread:detail": (id) ->
      controller.detail(id)
