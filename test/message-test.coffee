chai = require 'chai'
expect = chai.expect
sinon = require 'sinon'
sandbox = sinon.sandbox.create()

Message = require '../src/message'
json = require './valid.json'

describe 'Message', ->
  beforeEach ->
    process.env.HUBOT_HEROKU_TEMPLATE ||= ''

  describe 'exists HUBOT_HEROKU_TEMPLATE', ->
    beforeEach ->
      sandbox.stub(process.env, "HUBOT_HEROKU_TEMPLATE", 'Deploy {{{ user }}}: {{ app }}')
      @message = new Message(json)

    afterEach ->
      sandbox.restore()

    it '#build', ->
      expect(@message.build()).to.eq "Deploy test@example.com: cryptic-earth-3489"

  describe 'not exists HUBOT_HEROKU_TEMPLATE', ->
    beforeEach ->
      @message = new Message(json)

    it '#build', ->
      message = 'test@example.com deployed v3 (8657a6f) of cryptic-earth-3489 (http://cryptic-earth-3489.herokuapp.com)'
      expect(@message.build()).to.eq message
