define (require) ->
  Backbone = require("backbone")
  Channel = require("channel")
  require("entities/thread")

  class Category extends Backbone.Model
    parse: (response) ->
      id: parseInt(response.getAttribute("id"), 10)
      name: response.querySelector("name").textContent
      description: response.querySelector("description").textContent
      boards: new Boards(response.querySelectorAll("boards > board"), parse: yes)

  class Categories extends Backbone.Collection
    model: Category
    url: ->
      if Channel.request("app").isCordova
        return "http://forum.mods.de/bb/xml/boards.php"
      else
        return "api/boards.xml"

    parse: (response) ->
      _.toArray(response.querySelectorAll("categories > category"))

  class Board extends Backbone.Model
    url: ->
      if Channel.request("app").isCordova
        return "http://forum.mods.de/bb/xml/board.php?BID=#{@get("id")}"
      else
        return "api/board.xml"

    parse: (response) ->
      if (board = response.querySelector("board"))
        response = board

      id: parseInt(response.getAttribute("id"), 10)
      name: response.querySelector("name").textContent
      description: response.querySelector("description").textContent
      category_id: parseInt(response.querySelector("in-category").getAttribute("id"), 10)
      threads: Channel.request "entity:threads:create",
        response.querySelectorAll("threads > thread"), parse: yes

  class Boards extends Backbone.Collection
    model: Board

    parse: (response) ->
      _.toArray(response)

  Channel.connectRequests
    "entity:boards": ->
      promise = new Promise (resolve, reject) ->
        categories = new Categories
        categories.fetch
          dataType: "xml"
          success: resolve
          error: reject

      promise
    "entity:board": (id) ->
      promise = new Promise (resolve, reject) ->
        board = new Board(id: id)
        board.fetch
          dataType: "xml"
          success: resolve
          error: reject

      promise