define (require) ->
  Marionette = require("marionette")
  Template = require("hbs!components/user/login/templates/layout")
  Channel = require("channel")

  class UserLayoutView extends Marionette.LayoutView
    template: Template
    className: "user-login"
    ui:
      username: "#username"
      password: "#password"
      button: ".user-login-button"
    events:
      "click @ui.button": "onButtonClick"

    onButtonClick: ->
      @options.channel.execute("login", @ui.username.val(), @ui.password.val())