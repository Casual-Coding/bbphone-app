define (require) ->
  Marionette = require("marionette")
  Template = require("hbs!components/boards/list/templates/titlebar")

  class BoardsListTitlebarView extends Marionette.ItemView
    template: Template
    tagName: "h1"
