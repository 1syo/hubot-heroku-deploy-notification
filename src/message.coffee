# Description
#   A Message build message using Mustache.
#
Mustache = require 'mustache'

class Message
  constructor: (@json) ->

  template: ->
    process.env.HUBOT_HEROKU_TEMPLATE ||
      '{{{ user }}} deployed {{ release }} ({{ head }}) of {{ app }} ({{{ url }}})'

  build: ->
    Mustache.render(@template(), @json)

module.exports = Message
