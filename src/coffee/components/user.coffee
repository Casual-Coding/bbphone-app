define (require) ->
  Marionette = require("marionette")
  LayoutView = require("components/user/login/views/layoutView")
  TitlebarView = require("components/user/login/views/titlebarView")
  Channel = require("channel")

  require("entities/user")

  class UserController extends Marionette.Controller
    initialize: ->
      @channel = Channel.request("channel")
      @_setHandlers()

    showLogin: ->
      Channel.execute("view:show", new LayoutView(channel: @channel))
      Channel.execute("titlebar:show", new TitlebarView)

    logout: ->
      Channel.request("entity:user:logout")
      .then ->
        Channel.execute("router:navigate", "#")
      .catch (error) ->
        alert(error)

    _login: (username, password) ->
      Channel.request "entity:user:login",
        login_username: username
        login_password: password
        login_lifetime: 31536000
      .then ->
        Channel.execute("router:navigate", "#")
      .catch (error) ->
        alert(error)

    _setHandlers: ->
      @channel.connectCommands
        "login": @_login

  controller = new UserController

  Channel.connectCommands
    "user:login": ->
      controller.showLogin()
    "user:logout": ->
      controller.logout()