# Description
#   Postman build notice from json.
#
class Base
  constructor: (@req, @robot) ->
    @body = req.body

  room: ->
    @req.params.room || ""

  app: ->
    @body.app

  user: ->
    @body.user

  url: ->
    @body.url

  head: ->
    @body.head

  release: ->
    @body.release

  notice: ->
    "[Heroku] #{@user()} deployed #{@release()} (#{@head()}) of #{@app()} (#{@url()})"


class Common extends Base
  notify: ->
    @robot.send {room: @room()}, @notice()


class Slack extends Base
  text: ->
    "[Heroku] #{@user()} deployed #{@release()} (#{@head()}) of #{@url()}|#{@app()}"

  payload: ->
    message:
      room: @room()
    content:
      text: @text()
      color: "#244062"
      fallback: @notice()
      pretext: ""

  notify: ->
    @robot.emit 'slack-attachment', @payload()


class Postman
  @create: (req, robot) ->
    if robot.adapterName == 'slack'
      new Slack(req, robot)
    else
      new Common(req, robot)


module.exports = Postman
