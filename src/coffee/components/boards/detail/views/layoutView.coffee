define (require) ->
  Marionette = require("marionette")
  CollectionView = require("components/boards/detail/views/collectionView")
  Template = require("hbs!components/boards/detail/templates/layout")
  Channel = require("channel")

  class BoardDetailLayoutView extends Marionette.LayoutView
    template: Template
    regions:
      content: ".thread-list-wrapper"
    className: ".board-detail"
    ui:
      range: "[type=range]"
      bubble: ".pagination-bubble"
    events:
      "change @ui.range": "onChangeRange"
      "input @ui.range": "onInputRange"

    onChangeRange: ->
      Channel.execute("router:navigate", "#board/#{@model.get("id")}/#{@ui.range.val()}")

    onInputRange: ->
      @ui.bubble.text(@ui.range.val())

    onRender: ->
      if @model
        @content.show(new CollectionView(collection: @model.get("threads")))

    serializeData: ->
      if @model
        data = @model.toJSON()
        data.needsPagination = data.pages > 1
        data
