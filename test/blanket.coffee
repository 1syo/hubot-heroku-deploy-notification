require("blanket") {
  "data-cover-never": "node_modules"
  pattern: ["heroku-deploy-notifier.coffee", "postman.coffee"]
  loader: "./node-loaders/coffee-script"
}
