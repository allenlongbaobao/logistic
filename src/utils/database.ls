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
  db.logistic= {}
  for c in collections
    let collection-name = c
      db.logistic[collection-name] = db.collection collection-name
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
  (err, results) <-! db.logistic[collection-name].find query-obj .to-array
  console.log err if err
  throw err if err
  callback results

query-collection-with-options = !(collection-name, query-obj, options, callback)->
  (db) <-! get-db
  (err, results) <-! db.logistic[collection-name].find query-obj, options .to-array
  console.log err if err
  throw err if err
  callback results

save-single-document-in-database = !(collection-name, single-doc, callback)->
  (db) <-! get-db
  (err, results) <-! db.logistic[collection-name].insert single-doc
  if err and err.code is 11000 then callback err
  throw err if err
  callback results

find-and-modify = !(collection-name, critera, update, callback)->
  (db) <-! get-db
  (err, updated-obj) <-! db.logistic[collection-name].find-and-modify critera, {}, update, {new: true}
  throw err if err
  callback updated-obj

remove = !(collection-name, query-obj, callback)->
  (db) <-! get-db
  (err, count) <-! db.logistic[collection-name].remove query-obj, {safe: true}
  throw err if err
  callback count


module.exports =
  get-db: get-db
  shutdown: shutdown-mongo-client
  query-collection: query-collection
  query-collection-with-options: query-collection-with-options
  save-single-document-in-database: save-single-document-in-database
  find-and-modify: find-and-modify
  remove: remove
