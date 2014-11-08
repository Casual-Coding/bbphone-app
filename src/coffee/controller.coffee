define (require) ->
  Marionette = require("marionette")
  Channel = require("channel")
  require("components/boards")
  require("components/threads")

  class Controller extends Marionette.Controller
    showBoards: ->
      Channel.execute("boards:list")

    showBoard: (id) ->
      Channel.execute("board:detail", id)

    showThread: (id) ->
      Channel.execute("thread:detail", id)

  Channel.connectRequests
    "controller": ->
      new Controller