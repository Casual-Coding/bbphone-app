define (require) ->
  Marionette = require("marionette")
  Channel = require("channel")
  require("controller")

  class Router extends Marionette.AppRouter
    controller: Channel.request("controller")
    appRoutes:
      "": "showBoards"
      "board/:id/:page": "showBoard"
      "thread/:id/:page": "showThread"

  router = null
  init = ->
    router = new Router()

  Channel.connectCommands
    "router:init": init
    "router:navigate": (url) =>
      router.navigate(url, trigger: yes)