define (require) ->
  Marionette = require("marionette")
  CollectionView = require("components/boards/detail/views/collectionView")
  Template = require("hbs!components/boards/detail/templates/layout")

  class BoardDetailLayoutView extends Marionette.LayoutView
    template: Template
    regions:
      content: ".thread-list-wrapper"
    className: ".board-detail"

    onRender: ->
      if @options.model
        @content.show(new CollectionView(collection: @options.model.get("threads")))
