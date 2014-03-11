require! ['mongodb'.Db, 'mongodb'.Server, 'mongodb'.MongoClient, 'mongodb'.ObjectID, '../config/config']

db = null

init-mongo-client = !(callback)->
  if db
    callback!
  else
    db := new Db config.mongo.db, (new Server config.mongo.host, config.mongo.port), w: config.mongo.write-concern
    (err, db) <-! db.open
    if err then throw err
    <-! load-collections db, config.mongo.collections
    <-! add-index-for-collections
    callback!

load-collections = !(db, collections, callback)->
  db.weather-msger = {}
  for c in collections
    let collection-name = c
      db.weather-msger[collection-name] = db.collection collection-name
  callback!

add-index-for-collections = !(callback)->
  callback!

get-db = !(callback)->
  if !db
    <-! init-mongo-client
    callback db
  else
    callback db

shutdown-mongo-client = !(callback)->
  db.close!
  db := null
  callback!

query-collection = !(collection-name, query-obj, callback)->
  (db) <-! get-db
  (err, results) <-! db.weather-msger[collection-name].find query-obj .to-array
  console.log err if err
  throw err if err
  callback results

save-single-document-in-database = !(collection-name, single-doc, callback)->
  (db) <-! get-db
  (err, results) <-! db.weather-msger[collection-name].insert single-doc
  if err and err.code is 11000 then callback err
  throw err if err
  callback results

find-and-modify = !(collection-name, critera, update, callback)->
  (db) <-! get-db
  (err, updated-obj) <-! db.at-plus[collection-name].find-and-modify critera, {}, update, {new: true}
  throw err if err
  callback updated-obj

remove = !(collection-name, query-obj, callback)->
  (db) <-! get-db
  (err, count) <-! db.at-plus[collection-name].remove query-obj, {safe: true}
  throw err if err
  callback count


module.exports =
  get-db: get-db
  shutdown: shutdown-mongo-client
  query-collection: query-collection
  save-single-document-in-database: save-single-document-in-database
  find-and-modify: find-and-modify
  remove: remove
