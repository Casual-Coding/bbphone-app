define (require) ->
  Marionette = require("marionette")
  Channel = require("channel")
  require("components/boards")
  require("components/threads")

  class Controller extends Marionette.Controller
    showBoards: ->
      Channel.execute("boards:list")

    showBoard: (id, page) ->
      Channel.execute("board:detail", id, page)

    showThread: (id, page) ->
      Channel.execute("thread:detail", id, page)

  Channel.connectRequests
    "controller": ->
      new Controller