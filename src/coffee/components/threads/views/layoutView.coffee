define (require) ->
  Marionette = require("marionette")
  CollectionView = require("components/threads/views/collectionView")
  Template = require("hbs!components/threads/templates/layout")

  class ThreadLayoutView extends Marionette.LayoutView
    template: Template
    regions:
      content: ".post-list-wrapper"
    className: "thread-detail"

    onRender: ->
      if @options.model
        @content.show(new CollectionView(collection: @options.model.get("posts")))
