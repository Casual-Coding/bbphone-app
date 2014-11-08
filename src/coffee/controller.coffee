define (require) ->
  Marionette = require("marionette")
  Channel = require("channel")
  require("components/boards")

  class Controller extends Marionette.Controller
    showBoards: ->
      Channel.execute("boards:list")

    showBoard: (id) ->
      Channel.execute("board:detail", id)

  Channel.connectRequests
    "controller": ->
      new Controller