define (require) ->
  Backbone = require("backbone")
  Channel = require("channel")

  currentUser = null

  class User extends Backbone.Model
    url: ->
      if Channel.request("app").isCordova
        return "http://login.mods.de/"
      else
        return "api/thread.xml"

    parse: (response) ->
      if (user = response.querySelector("user"))
        response = user

      id: parseInt(response.getAttribute("id"), 10)
      name: response.textContent

    login: ->
      new Promise (resolve, reject) =>
        options =
          data: @toJSON()
          dataType: "html"
          processData: yes
          success: (response, status, request) =>
            if (response.match(/Erfolgreich eingeloggt/ig) || []).length > 0
              if (match = response.match(/SSO\.php\?UID=(\d+)&login=(.*?)&lifetime=(\d+)/))
                currentUser = @

                currentUser.set("username", @get("login_username"))
                currentUser.set("id", parseInt(match[1], 10))

                @unset("login_username")
                @unset("login_password")
                @unset("login_lifetime")

                $.get("http://forum.mods.de/SSO.php?UID=#{match[1]}&login=#{match[2]}&lifetime=#{match[3]}", resolve)
            else if (response.match(/Passwort falsch/ig) || []).length > 0
              reject("Benutzername oder Kennwort falsch")
            else
              reject("Login-Fehler")
          error: ->
            reject("Login-Fehler")

        Backbone.sync("create", @, options)

  class Users extends Backbone.Collection
    model: User

    parse: (response) ->
      _.toArray(response)

  Channel.connectCommands
    "entity:user:current": (id) ->
      if currentUser is null
        currentUser = new User(id: id)

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
    "entity:user:login": (data) ->
      user = new User(data)
      user.login()
    "entity:user:logout": ->
      new Promise (resolve, reject) ->
        $.get("http://login.mods.de/logout/?&UID=23349&a=TY7r&redirect=")
    "entity:user:current": ->
      currentUser