define (require) ->
  Marionette = require("marionette")
  CollectionView = require("components/boards/list/views/collectionView")
  Template = require("hbs!components/boards/list/templates/layout")

  class BoardsListLayoutView extends Marionette.LayoutView
    template: Template
    className: "category-list-wrapper"
    regions:
      content: ".category-list"

    onRender: ->
      @content.show(new CollectionView(collection: @options.collection))
