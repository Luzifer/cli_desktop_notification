#!node_modules/.bin/coffee

request = require 'request'
couchdb = require 'felix-couchdb'
colors = require 'colors'

settings = require './settings'

client = couchdb.createClient settings.database.port, settings.database.host, settings.database.user, settings.database.pass
db = client.db settings.database.name

max_fetched_timestamp = 0

fetch_notifications = () ->
  db.view 'notifications', 'by_date',
    "startkey": max_fetched_timestamp + 1
    "descending": false
  , display_notifications

display_notifications = (err, data) ->
  for row in data.rows
    console.log "#{row.value.date}: #{row.value.title} (#{row.value.appname})".bold.grey
    if row.value.content != ''
      console.log "                     #{row.value.content}"

    if row.key > max_fetched_timestamp
      max_fetched_timestamp = row.key

repeat = (delay, fkt) ->
  setInterval fkt, delay

repeat 5000, fetch_notifications
