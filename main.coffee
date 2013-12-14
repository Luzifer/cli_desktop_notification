#!node_modules/.bin/coffee

request = require 'request'
couchdb = require 'felix-couchdb'
dateformat = require 'dateformat'

settings = require './settings'

client = couchdb.createClient settings.database.port, settings.database.host, settings.database.user, settings.database.pass
db = client.db settings.database.name

max_fetched_timestamp = 0

query_notifications = () ->
  request.post
    uri: 'https://projects.hci.simtech.uni-stuttgart.de/tapsnap/notification/php/get.php?version=31&slowlevel=0',
    form:
      code: settings.code
    strictSSL: false
  , process_notifications
    

process_notifications = (error, response, body) ->
  # [{"id":31357,"title":"Desktop Notifications","content":"Test Notification [9]","appname":"Desktop Notifications","package":"org.hcilab.projects.notification","info":"","time":"1387012706108"}]
  notifications = JSON.parse body
  my_max_fetched_timestamp = 0
  for notification in notifications
    ntime = parseInt(notification.time)
    if ntime <= max_fetched_timestamp
      continue
    notification.timestamp = Math.round(ntime / 1000)
    notification.date = dateformat(ntime, 'yyyy-mm-dd hh:MM:ss')
    db.saveDoc(notification)
    if ntime > my_max_fetched_timestamp
      my_max_fetched_timestamp = ntime
  if my_max_fetched_timestamp > max_fetched_timestamp
    max_fetched_timestamp = my_max_fetched_timestamp

cleanup_notifications = () ->
  delete_older_than = Math.round((new Date()).getTime() / 1000) - settings.expires - 1
  console.log delete_older_than
  db.view 'notifications', 'by_date',
    "startkey": delete_older_than
    "descending": true
  , delete_notifications

delete_notifications = (err, data) ->
  for row in data.rows
    db.removeDoc row.id, row.value._rev

repeat = (delay, fkt) ->
  setInterval fkt, delay

repeat settings.query_interval * 1000, query_notifications
repeat 3600, cleanup_notifications
