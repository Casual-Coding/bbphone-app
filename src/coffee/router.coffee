define (require) ->
  Marionette = require("marionette")
  Channel = require("channel")
  require("controller")

  class Router extends Marionette.AppRouter
    controller: Channel.request("controller")
    appRoutes:
      "": "showBoards"
      "board/:id": "showBoard"
      "thread/:id": "showThread"

  init = ->
    new Router()

  Channel.connectCommands
    "router:init": init