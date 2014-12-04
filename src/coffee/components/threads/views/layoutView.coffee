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
      spoiler: ".spoiler"
    events:
      "change @ui.range": "onRangeChange"
      "input @ui.range": "onRangeInput"
      "click @ui.spoiler": "onSpoilerClick"

    onRangeChange: ->
      Channel.execute("router:navigate", "#thread/#{@model.get("id")}/#{@ui.range.val()}")

    onRangeInput: ->
      @ui.bubble.text(@ui.range.val())

    onSpoilerClick: (ev) ->
      $(ev.currentTarget).toggleClass("active")

    onRender: ->
      if @model
        @content.show(new CollectionView(collection: @model.get("posts")))

    serializeData: ->
      if @model
        data = @model.toJSON()
        data.needsPagination = data.pages > 1
        data
