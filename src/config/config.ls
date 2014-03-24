module.exports =
  port: 4000
  url: 'http://localhost:4000'

  mongo:
    db: 'logistic-follower'
    host: 'localhost'
    port: 27017
    write-concern: -1
    collections: ['goods', 'users', 'courier']
  baidu-map-url: 'http://api.map.baidu.com/geocoder/v2'
  ak: '7E5AC0bfb3c61d2d80cb86986ec42dbf'

  host-email: '415619323@qq.com'
  host-password: 'ksda21064711'
  #third-party-account:
    #TODO
    #新浪微博和twitter

