define (require) ->
  Marionette = require("marionette")
  LayoutView = require("components/user/views/layoutView")
  TitlebarView = require("components/user/views/titlebarView")
  Channel = require("channel")

  require("entities/user")

  class UserController extends Marionette.Controller
    login: ->
      Channel.execute("view:show", new LayoutView)
      Channel.execute("titlebar:show", new TitlebarView)

  controller = new UserController

  Channel.connectCommands
    "user:login": ->
      controller.login()
