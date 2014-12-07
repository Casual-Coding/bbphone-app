define (require) ->
  Marionette = require("marionette")
  Template = require("hbs!components/user/login/templates/titlebar")

  class ThreadTitlebarView extends Marionette.ItemView
    template: Template
    tagName: "h1"