define (require) ->
  Marionette = require("marionette")
  ItemView = require("components/boards/detail/views/itemView")

  class BoardDetailCollectionView extends Marionette.CollectionView
    childView: ItemView
    className: "thread-list"
