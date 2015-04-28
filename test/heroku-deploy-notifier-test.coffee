Robot = require("hubot/src/robot")

chai = require 'chai'
expect = chai.expect
request = require 'supertest'

json = require './valid.json'

describe 'hubot-deploy-notifier', ->
  robot = null
  beforeEach (done) ->
    robot = new Robot null, 'mock-adapter', yes, 'hubot'
    robot.adapter.on 'connected', ->
      require("../src/heroku-deploy-notifier")(robot)
      done()
    robot.run()

  it 'should be valid', (done) ->
    request(robot.router)
      .post('/hubot/heroku/general')
      .set('Accept','application/x-www-form-urlencoded')
      .send(json)
      .expect(200)
      .end (err, res) ->
        expect(res.text).to.eq "[Heroku] Sending message"
        throw err if err
        done()

  afterEach ->
    robot.server.close()
    robot.shutdown()
