define (require) ->
  Marionette = require("marionette")
  ItemView = require("components/boards/list/views/itemView")
  Template = require("hbs!components/boards/list/templates/composite")

  class BoardsListCompositeView extends Marionette.CompositeView
    template: Template
    childView: ItemView
    childViewContainer: ".board-list"
