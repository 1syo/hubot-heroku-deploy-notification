require("blanket") {
  pattern: [
    "heroku-deploy-notifier/src/heroku-deploy-notifier.coffee",
    "heroku-deploy-notifier/src/message.coffee"
  ]
  loader: "./node-loaders/coffee-script"
}
