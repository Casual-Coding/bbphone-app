define (require) ->
  Marionette = require("marionette")
  ItemView = require("components/threads/views/itemView")

  class ThreadCollectionView extends Marionette.CollectionView
    childView: ItemView
    className: "post-list"
