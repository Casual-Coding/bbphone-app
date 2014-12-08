define (require) ->
  Marionette = require("marionette")
  ListLayoutView = require("components/boards/list/views/layoutView")
  ListTitlebarView = require("components/boards/list/views/titlebarView")
  DetailLayoutView = require("components/boards/detail/views/layoutView")
  DetailTitlebarView = require("components/boards/detail/views/titlebarView")
  Channel = require("channel")

  require("entities/boards")

  class BoardsController extends Marionette.Controller
    currentId: null

    initialize: ->
      @channel = Channel.request("channel")

      @_setEventHandlers()

    list: ->
      promise = Channel.request("entity:boards")
      promise.then (boards) =>
        Channel.execute("view:show", new ListLayoutView
          collection: boards
          channel: @channel
        )
      Channel.execute("view:show", new ListLayoutView)
      Channel.execute("titlebar:show", new ListTitlebarView)

    detail: (id, page = 1) ->
      promise = Channel.request("entity:board", id, page: page)
      promise.then (board) =>
        @currentId = id

        Channel.execute("view:show", new DetailLayoutView
          model: board
          channel: @channel
        )
        Channel.execute("titlebar:show", new DetailTitlebarView
          model: board)

      Channel.execute("view:show", new DetailLayoutView)
      Channel.execute("titlebar:show", new DetailTitlebarView)

    onDestroy: ->
      @channel.reset()

    _setEventHandlers: ->
      @channel.connectEvents
        "range:change": (value) =>
          Channel.execute("router:navigate", "board/#{@currentId}/#{value}")

  controller = new BoardsController

  Channel.connectCommands
    "boards:list": ->
      controller.list()
    "board:detail": (id, page) ->
      controller.detail(id, page)
