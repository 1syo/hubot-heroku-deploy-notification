require("blanket") {
  "data-cover-never": "node_modules"
  pattern: ["heroku-deploy-notification.coffee", "postman.coffee"]
  loader: "./node-loaders/coffee-script"
}
