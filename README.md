# luzifer / cli\_desktop\_notification

I wrote this app because I wanted to have my Android notifications displayed in a stream inside a pane of my tmux window covering one of my screens. So I can read notifications without pulling out my phone and still be able to read them even if I am not at my desk when they appear. The browser plugin automatically closes the notifications and they are annoying popups and distract me while working. The output in the terminal just sits there and does not disturb my work.

## Requirements

- CouchDB with password security
- [Desktop Notifications](https://play.google.com/store/apps/details?id=org.hcilab.projects.notification) installed on the Android device

## Deployment

1. Clone this repository
1. Register a new app on Heroku
1. Create a new branch and add your credentials
1. Deploy that branch to your Heroku app
1. Start the client

### Example commands

```
$ git clone git://github.com/Luzifer/cli_desktop_notification.git
$ heroku apps:create
$ git co -b deploy
$ vim settings.json
$ git commit -av -m 'Added credentials'
$ git push heroku deploy:master
$ node_modules/.bin/coffee client.coffee
```
