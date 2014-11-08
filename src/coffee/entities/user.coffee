define (require) ->
  Backbone = require("backbone")
  Channel = require("channel")

  class User extends Backbone.Model
    parse: (response) ->
      if (user = response.querySelector("user"))
        response = user

      id: parseInt(response.getAttribute("id"), 10)
      name: response.textContent

  class Users extends Backbone.Collection
    model: User

    parse: (response) ->
      _.toArray(response)

  Channel.connectRequests
    "entity:users": ->
      new Promise (resolve, reject) ->
        users = new Users
        users.fetch
          dataType: "xml"
          success: resolve
          error: reject
    "entity:users:create": (data, options = {}) ->
      new Users(data, options)
    "entity:user": (id) ->
      new Promise (resolve, reject) ->
        user = new User(id: id)
        user.fetch
          dataType: "xml"
          success: resolve
          error: reject
    "entity:user:create": (data, options = {}) ->
      new User(data, options)