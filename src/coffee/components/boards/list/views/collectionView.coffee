define (require) ->
  Marionette = require("marionette")
  CompositeView = require("components/boards/list/views/compositeView")

  class BoardsListCollectionView extends Marionette.CollectionView
    childView: CompositeView
    childViewOptions: (model) ->
      collection: model.get("boards")
    className: "board-list-wrapper"
