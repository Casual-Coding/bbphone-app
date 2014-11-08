define (require) ->
  Marionette = require("marionette")
  CollectionView = require("components/threads/views/collectionView")
  Template = require("hbs!components/threads/templates/layout")
  Channel = require("channel")

  class ThreadLayoutView extends Marionette.LayoutView
    template: Template
    regions:
      content: ".post-list-wrapper"
    className: "thread-detail"
    ui:
      range: "[type=range]"
      bubble: ".pagination-bubble"
    events:
      "change @ui.range": "onChangeRange"
      "input @ui.range": "onInputRange"

    onChangeRange: ->
      Channel.execute("router:navigate", "#thread/#{@model.get("id")}/#{@ui.range.val()}")

    onInputRange: ->
      @ui.bubble.text(@ui.range.val())

    onRender: ->
      if @model
        @content.show(new CollectionView(collection: @model.get("posts")))

    serializeData: ->
      if @model
        data = @model.toJSON()
        data.needsPagination = data.pages > 1
        data
