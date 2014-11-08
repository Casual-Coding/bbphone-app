define (require) ->
  Marionette = require("marionette")
  Template = require("hbs!components/threads/templates/titlebar")

  class ThreadTitlebarView extends Marionette.ItemView
    template: Template
    tagName: "h1"
