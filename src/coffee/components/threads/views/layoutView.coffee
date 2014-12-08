define (require) ->
  Marionette = require("marionette")
  CollectionView = require("components/threads/views/collectionView")
  Template = require("hbs!components/threads/templates/layout")
  Channel = require("channel")

  class ThreadLayoutView extends Marionette.LayoutView
    template: Template
    regions:
      content: ".post-list-wrapper"
      pagination: ".pagination"
    className: "thread-detail"
    ui:
      spoiler: ".spoiler"
      links: "a[href^=\"http://\"], a[href^=\"https://\"]"
    events:
      "click @ui.spoiler": "onSpoilerClick"
      "click @ui.links": "onLinkClick"

    onSpoilerClick: (ev) ->
      $(ev.currentTarget).toggleClass("active")

    onLinkClick: (ev) ->
      url = $(ev.currentTarget).attr("href")
      @options.channel.trigger("link:click", url)

      ev.preventDefault()
      ev.stopPropagation()

    onRender: ->
      if @model
        @content.show(new CollectionView(collection: @model.get("posts")))

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
