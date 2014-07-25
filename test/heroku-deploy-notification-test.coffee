Robot = require("hubot/src/robot")

chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect
request = require 'supertest'

describe 'hubot-deploy-notification', ->
  robot = null
  beforeEach (done) ->
    robot = new Robot null, 'mock-adapter', yes, 'hubot'
    robot.adapter.on 'connected', ->
      require("../src/heroku-deploy-notification")(robot)
      adapter = @robot.adapter
      done()
    robot.run()

  it 'should be valid', (done) ->
    params =
      app: "the app name"
      user: "email of the user deploying the app"
      url: "http://myapp.heroku.com"
      head: "short identifier of the latest commit"
      head_long: "full identifier of the latest commit"
      git_log: "log of commits between this deploy and the last"

    request(robot.router)
      .post('/hubot/heroku/general')
      .set('Accept','application/x-www-form-urlencoded')
      .send(params)
      .expect(200)
      .end (err, res) ->
        expect(res.text).to.eq "[Heroku] Sending message"
        throw err if err
        done()

  afterEach ->
    robot.server.close()
    robot.shutdown()
