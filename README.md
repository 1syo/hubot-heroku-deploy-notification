# hubot-heroku-deploy-notifier

[![Coverage Status](http://img.shields.io/coveralls/1syo/hubot-heroku-deploy-notifier.svg?style=flat)](https://coveralls.io/r/1syo/hubot-heroku-deploy-notifier)
[![Dependencies Status](http://img.shields.io/david/1syo/hubot-heroku-deploy-notifier.svg?style=flat)](https://david-dm.org/1syo/hubot-heroku-deploy-notifier)

A hubot script that notify deploy status from heroku deploy hooks

See [`src/heroku-deploy-notifier.coffee`](src/heroku-deploy-notifier.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-heroku-deploy-notifier --save`

Then add **hubot-heroku-deploy-notifier** to your `external-scripts.json`:

```json
["hubot-heroku-deploy-notifier"]
```

## Heroku configuration

See also:  
https://devcenter.heroku.com/articles/deploy-hooks#http-post-hook

## Notification examples

If you use slack adapter then your notice use Slack attachments.

### Slack Adapter

...

### Slack Adapter (fallback)

...

### Shell Adapter

...
