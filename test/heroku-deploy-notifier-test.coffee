Robot = require("hubot/src/robot")

chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect
request = require 'supertest'

describe 'hubot-deploy-notifier', ->
  robot = null
  beforeEach (done) ->
    robot = new Robot null, 'mock-adapter', yes, 'hubot'
    robot.adapter.on 'connected', ->
      require("../src/heroku-deploy-notifier")(robot)
      adapter = @robot.adapter
      done()
    robot.run()

  it 'should be valid', (done) ->
    params =
      app: "cryptic-earth-3489"
      user: "test@example.com"
      url: "http://cryptic-earth-3489.herokuapp.com"
      head_long: "8657a6f9dbc90aaf61763c741b2296febe2f3ebe"
      head: "8657a6f"
      release: "v3"
      git_log: ""
      prev_head: ""

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
