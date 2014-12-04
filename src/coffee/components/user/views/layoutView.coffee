define (require) ->
  Marionette = require("marionette")
  Template = require("hbs!components/user/templates/layout")
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
      Channel.request "entity:user:login",
        login_username: @ui.username.val()
        login_password: @ui.password.val()
        login_lifetime: 31536000
      .then ->
        Channel.execute("router:navigate", "#")
      .catch (error) ->
        alert(error)