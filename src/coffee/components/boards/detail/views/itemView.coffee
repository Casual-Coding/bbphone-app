define (require) ->
  Marionette = require("marionette")
  Template = require("hbs!components/boards/detail/templates/item")

  class BoardDetailItemView extends Marionette.ItemView
    template: Template
    className: "thread-list-item"
