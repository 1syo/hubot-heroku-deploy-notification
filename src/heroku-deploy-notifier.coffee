# Description
#   A hubot script that notify deploy status from heroku deploy webhook
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None
#
# URLS:
#   POST /<hubot host>:<hubot port>/heroku/<room>
#
# Notes:
#   https://devcenter.heroku.com/articles/deploy-hooks#http-post-hook
#
# Author:
#   TAKAHASHI Kazunari[takahashi@1syo.net]
#
Message = require "./message"
module.exports = (robot) ->
  robot.router.post "/#{robot.name}/heroku/:room", (req, res) ->
    try
      message = new Message(req.body)
      robot.send { room: req.params.room }, message.build()

      res.end "[Heroku] Sending message"
    catch e
      res.end "[Heroku] #{e}"
