# luzifer / cli\_desktop\_notification

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
