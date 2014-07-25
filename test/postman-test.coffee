chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect

Postman = require '../src/postman'

describe 'Postman', ->
  beforeEach ->
    @params =
      app: "the app name"
      user: "test@example.com"
      url: "http://myapp.heroku.com"
      head: "9fc04edee178f29b14f20d560176bc4da92fea5d"
      head_long: "full identifier of the latest commit"
      git_log: "log of commits between this deploy and the last"

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
      expect(@postman.head()).to.eq "9fc04ed"

    it '#message', ->
      expect(@postman.message()).to.eq """
        [Heroku] test@example.com deployed a new version of the app name (9fc04ed)
        http://myapp.heroku.com
        """

    it "#deliver", ->
      @postman.deliver()
      expect(@robot.send).to.have.been.calledWith(
        {room: @postman.room()}, @postman.message()
      )

  describe 'Slack', ->
    beforeEach ->
      @robot =
        adapterName: "slack"
        emit: sinon.spy()

      @postman = Postman.create(@req, @robot)

    it "#payload", ->
      expect(@postman.payload().message["room"]).to.eq "general"
      expect(@postman.payload().content["pretext"]).to.eq @postman.message()

    it "#deliver", ->
      @postman.deliver()
      expect(@robot.emit).to.have.been.calledWith(
        'slack-attachment', @postman.payload()
      )
