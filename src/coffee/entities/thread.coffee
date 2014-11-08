define (require) ->
  Backbone = require("backbone")
  Channel = require("channel")
  require("entities/post")
  # require("entities/user")

  class Thread extends Backbone.Model
    url: ->
      if Channel.request("app").isCordova
        return "http://forum.mods.de/bb/xml/thread.php?TID=#{@get("id")}&page=#{@get("page")}"
      else
        return "api/thread.xml"

    parse: (response, options = {}) ->
      if (thread = response.querySelector("thread"))
        response = thread
        page = parseInt(response.querySelector("posts").getAttribute("page"), 10)

      id: parseInt(response.getAttribute("id"), 10)
      title: response.querySelector("title").textContent
      subtitle: response.querySelector("subtitle").textContent
      board_id: parseInt(response.querySelector("in-board").getAttribute("id"), 10)
      pages: parseInt(response.querySelector("number-of-pages").getAttribute("value"), 10)
      page: page or 1
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
    "entity:thread": (id, options = {}) ->
      new Promise (resolve, reject) ->
        thread = new Thread
          id: id
          page: options.page
        thread.fetch
          dataType: "xml"
          success: resolve
          error: reject