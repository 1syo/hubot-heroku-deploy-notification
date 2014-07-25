# Description
#   A hubot script that does the things
#
class Base
  constructor: (req, @robot) ->
    @_room = req.params.room
    @body = req.body

  room: ->
    @_room

  app: ->
    @body.app

  user: ->
    @body.user

  url: ->
    @body.url

  head: ->
    @body.head.substr(0, 7)


class Common extends Base
  message: ->
    """
    [Heroku] #{@user()} deployed a new version of #{@app()} (#{@head()})
    #{@url()}
    """

  deliver: ->
    @robot.send {room: @room()}, @message()

class Slack extends Base
  message: ->
    "[Heroku] #{@user()} deployed a new version of #{@url()}|#{@app()} (#{@head()})"

  payload: ->
    message:
      room: @room()
    content:
      text: ""
      color: "#244062"
      fallback: ""
      pretext: @message()

  deliver: ->
    @robot.emit 'slack-attachment', @payload()


class Postman
  @create: (req, robot) ->
    if robot.adapterName == 'slack'
      new Slack(req, robot)
    else
      new Common(req, robot)


module.exports = Postman
