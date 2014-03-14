module.exports =
  port: 4000
  url: 'http://localhost:4000'

  mongo:
    db: 'logistic-follower'
    host: 'localhost'
    port: 27017
    write-concern: -1
    collections: ['goods', 'users', 'courier']

  #third-party-account:
    #TODO
    #新浪微博和twitter

