define (require) ->
  Backbone = require("backbone")
  Channel = require("channel")
  moment = require("moment")
  require("entities/user")

  class Post extends Backbone.Model
    parse: (response, options = {}) ->
      if (post = response.querySelector("post"))
        response = post

      bookmarkToken = null
      if bookmarkToken = response.querySelector("token-setbookmark")
        bookmarkToken = bookmarkToken.getAttribute("value")

      editToken = null
      if editToken = response.querySelector("token-editreply")
        editToken = editToken.getAttribute("value")

      editCount = response.querySelector("message > edited").getAttribute("count")

      lastEdited = null
      if editCount > 0
        lastEdited = moment.unix(response.querySelector("message > edited date").getAttribute("timestamp"))


      id: parseInt(response.getAttribute("id"), 10)
      title: response.querySelector("message > title").textContent
      content: response.querySelector("message > content").textContent
      thread: options.thread
      tokens:
        bookmark: bookmarkToken
        edit: editToken
      avatar: response.querySelector("avatar").textContent
      date: moment.unix(response.querySelector("date").getAttribute("timestamp"))
      edited: editCount > 0
      lastEdited: lastEdited
      user: Channel.request "entity:user:create",
        response.querySelector("user"),
        parse: yes

    toJSON: ->
      data = super
      data.user = data.user.toJSON()
      data

  class Posts extends Backbone.Collection
    model: Post

    parse: (response, options = {}) ->
      _.toArray(response)

  Channel.connectRequests
    "entity:posts": ->
      new Promise (resolve, reject) ->
        posts = new Posts
        posts.fetch
          dataType: "xml"
          success: resolve
          error: reject
    "entity:posts:create": (data, options = {}) ->
      new Posts(data, options)
    "entity:post": (id) ->
      new Promise (resolve, reject) ->
        post = new Post(id: id)
        post.fetch
          dataType: "xml"
          success: resolve
          error: reject