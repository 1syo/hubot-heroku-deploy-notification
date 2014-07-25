# Description
#   A hubot script that does the things
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   TAKAHASHI Kazunari[takahashi@1syo.net]
Postman = require "./postman"
module.exports = (robot) ->
  robot.router.post "/#{robot.name}/heroku/:room", (req, res) ->
    try
      postman = Postman.create(req, robot)
      postman.deliver()
      res.end "[Heroku] Sending message"
    catch e
      res.end "[Heroku] #{e}"
