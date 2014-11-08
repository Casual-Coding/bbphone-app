define (require) ->
  Marionette = require("marionette")
  Template = require("hbs!components/boards/list/templates/item")

  class BoardsListItemView extends Marionette.ItemView
    template: Template
    className: "board-list-item"
