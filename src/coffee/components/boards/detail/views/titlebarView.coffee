define (require) ->
  Marionette = require("marionette")
  Template = require("hbs!components/boards/detail/templates/titlebar")

  class BoardViewTitlebarView extends Marionette.ItemView
    template: Template
    tagName: "h1"
