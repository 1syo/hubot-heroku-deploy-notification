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
Postman = require "./postman"
module.exports = (robot) ->
  robot.router.post "/#{robot.name}/heroku/:room", (req, res) ->
    try
      postman = new Postman(req, robot)
      postman.notify()
      res.end "[Heroku] Sending message"
    catch e
      res.end "[Heroku] #{e}"
