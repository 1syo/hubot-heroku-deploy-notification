chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect

Postman = require '../src/postman'

describe 'Postman', ->
  beforeEach ->
    @params =
      app: "cryptic-earth-3489"
      user: "test@example.com"
      url: "http://cryptic-earth-3489.herokuapp.com"
      head_long: "8657a6f9dbc90aaf61763c741b2296febe2f3ebe"
      head: "8657a6f"
      release: "v3"
      git_log: ""
      prev_head: ""

    @req =
      body: @params
      params:
        room: "general"

  describe 'Common', ->
    beforeEach ->
      @robot =
        adapterName: "shell"
        send: sinon.spy()

      @postman = Postman.create(@req, @robot)

    it '#room', ->
      expect(@postman.room()).to.eq "general"

    it '#url', ->
      expect(@postman.url()).to.eq @params.url

    it '#user', ->
      expect(@postman.user()).to.eq @params.user

    it '#head', ->
      expect(@postman.head()).to.eq @params.head

    it '#release', ->
      expect(@postman.release()).to.eq @params.release


    it '#notice', ->
      expect(@postman.notice()).to.eq """
        [Heroku] test@example.com deployed v3 (8657a6f) of cryptic-earth-3489 (http://cryptic-earth-3489.herokuapp.com)
        """

    it "#notify", ->
      @postman.notify()
      expect(@robot.send).to.have.been.calledWith(
        {room: @postman.room()}, @postman.notice()
      )

  describe 'Slack', ->
    beforeEach ->
      @robot =
        adapterName: "slack"
        emit: sinon.spy()

      @postman = Postman.create(@req, @robot)

    it "#payload", ->
      expect(@postman.payload().message.room).to.eq "general"
      expect(@postman.payload().content.pretext).to.eq @postman.pretext()
      expect(@postman.payload().content.fallback).to.eq @postman.notice()

    it "#notify", ->
      @postman.notify()
      expect(@robot.emit).to.have.been.calledWith(
        'slack-attachment', @postman.payload()
      )
