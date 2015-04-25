# Description
#   Postman build notice from json.
#
class Postman
  constructor: (@req, @robot) ->
    @body = @req.body

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

  notify: ->
    @robot.send {room: @room()}, @notice()

module.exports = Postman
