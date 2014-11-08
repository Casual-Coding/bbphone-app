define (require) ->
  Marionette = require("marionette")
  LayoutView = require("components/threads/views/layoutView")
  TitlebarView = require("components/threads/views/titlebarView")
  Channel = require("channel")

  require("entities/thread")

  class ThreadsController extends Marionette.Controller
    detail: (id, page) ->
      promise = Channel.request("entity:thread", id, page: page)
      promise.then (thread) ->
        Channel.execute("view:show", new LayoutView
          model: thread
        )
        Channel.execute("titlebar:show", new TitlebarView
          model: thread)

      Channel.execute("view:show", new LayoutView)
      Channel.execute("titlebar:show", new TitlebarView)

  controller = new ThreadsController

  Channel.connectCommands
    "thread:detail": (id, page) ->
      controller.detail(id, page)
