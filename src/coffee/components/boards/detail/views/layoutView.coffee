define (require) ->
  Marionette = require("marionette")
  CollectionView = require("components/boards/detail/views/collectionView")
  Template = require("hbs!components/boards/detail/templates/layout")
  Channel = require("channel")

  class BoardDetailLayoutView extends Marionette.LayoutView
    template: Template
    regions:
      content: ".thread-list-wrapper"
      pagination: ".pagination"
    className: ".board-detail"

    onRender: ->
      if @model
        @content.show(new CollectionView(collection: @model.get("threads")))

        @pagination.show Channel.request "ui:range",
          min: 1
          max: @model.get("pages")
          value: @model.get("page")
          channel: @options.channel

    serializeData: ->
      if @model
        data = @model.toJSON()
        data.needsPagination = data.pages > 1
        data
