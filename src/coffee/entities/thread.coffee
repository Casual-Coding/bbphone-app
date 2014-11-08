define (require) ->
  Backbone = require("backbone")
  Channel = require("channel")
  require("entities/post")
  # require("entities/user")

  class Thread extends Backbone.Model
    url: ->
      if Channel.request("app").isCordova
        return "http://forum.mods.de/bb/xml/thread.php?TID=#{@get("id")}"
      else
        return "api/thread.xml"

    parse: (response, options = {}) ->
      if (thread = response.querySelector("thread"))
        response = thread

      id: parseInt(response.getAttribute("id"), 10)
      title: response.querySelector("title").textContent
      subtitle: response.querySelector("subtitle").textContent
      board_id: parseInt(response.querySelector("in-board").getAttribute("id"), 10)
      posts: Channel.request "entity:posts:create",
        response.querySelectorAll("posts > post"), parse: yes, thread: this

  class Threads extends Backbone.Collection
    model: Thread

    parse: (response, options = {}) ->
      _.toArray(response)

  Channel.connectRequests
    "entity:threads": ->
      new Promise (resolve, reject) ->
        threads = new Threads
        threads.fetch
          dataType: "xml"
          success: resolve
          error: reject
    "entity:threads:create": (data, options = {}) ->
      new Threads(data, options)
    "entity:thread": (id) ->
      new Promise (resolve, reject) ->
        thread = new Thread(id: id)
        thread.fetch
          dataType: "xml"
          success: resolve
          error: reject