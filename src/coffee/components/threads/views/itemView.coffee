define (require) ->
  Marionette = require("marionette")
  Template = require("hbs!components/threads/templates/item")

  class ThreadItemView extends Marionette.ItemView
    template: Template
    className: "post-list-item"
