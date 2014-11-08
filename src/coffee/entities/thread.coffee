define (require) ->
  Backbone = require("backbone")
  Channel = require("channel")

  class Thread extends Backbone.Model
    url: ->
      if Channel.request("app").isCordova
        return "http://forum.mods.de/bb/xml/board.php?BID=#{@get("id")}"
      else
        return "api/thread.xml"

    parse: (response) ->
      if (thread = response.querySelector("thread"))
        response = thread

      id: parseInt(response.getAttribute("id"), 10)
      title: response.querySelector("title").textContent
      subtitle: response.querySelector("subtitle").textContent
      board_id: parseInt(response.querySelector("in-board").getAttribute("id"), 10)

  class Threads extends Backbone.Collection
    model: Thread

    parse: (response) ->
      _.toArray(response)

  Channel.connectRequests
    "entity:threads": ->
      promise = new Promise (resolve, reject) ->
        threads = new Threads
        threads.fetch
          dataType: "xml"
          success: resolve
          error: reject

      promise
    "entity:threads:create": (data, options = {}) ->
      new Threads(data, options)
    "entity:thread": (id) ->
      promise = new Promise (resolve, reject) ->
        thread = new Thread(id: id)
        thread.fetch
          dataType: "xml"
          success: resolve
          error: reject

      promise