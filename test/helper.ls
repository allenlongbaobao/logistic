require! ['http', '../bin/config/config']
_ = require 'underscore'

options =
  hostname: 'localhost'
  port: config.port
  path: ''
  method: 'GET'

result = ''
get-data-and-callback = !(res, callback)->
  res.set-encoding 'utf-8'
  res.on 'data', !(chunk)->
    result += chunk

  res.on 'end', !->
    result := JSON.parse result
    callback result
    result := ''

  res.on 'error', !(err)->
    console.log err

turn-request-data-into-path = !(method, request-data, callback)->
  path = method + '?'
  _.each request-data, !(value, key, list)->
    path += key + '=' + value
  callback path

module.exports =
  get: !(method, request-data, callback)->
    (path) <-! turn-request-data-into-path method, request-data
    get-options = options <<< {path: path, method: 'GET'}
    req = http.request get-options, !(res)->
      get-data-and-callback res, callback
    req.on 'error', !(err)->
      console.log err
    req.end!

  post: !(method, request-data, callback)->
    (path) <-! turn-request-data-into-path method, request-data
    get-options = options <<< {path: path, method: 'POST'}
    req = http.request get-options, !(res)->
      get-data-and-callback res, callback
    req.on 'error', !(err)->
      console.log err
    req.end!
  #TODO
  #del:
  #put:


