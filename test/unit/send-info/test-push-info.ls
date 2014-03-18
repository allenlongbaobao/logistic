describe "测试货物信息的推送: send-info", !->
  url = config.url + '/send-info'
  before-each !(done)->
    utils.clean-db-and-load-fixture 'unit/send-info', ['goods'], done

  can '发送的请求中的缺少参数， 服务器相应400', !(done)->
    request-data =
      location:
        latitude: 123
        longitude: 123
        altitude: 123
      goods:
        gid: 'gid-1'
        name: '哑铃'
      date: new Date!
        #courier:
        #name: '小明'
    request-string-data = querystring.escape JSON.stringify request-data
    request.post url + "/?" + request-string-data, !(err, res, body)->
      res.status-code.should.eql 400
      body.should.eql 'bad request'
      done!

  can '发送的请求中goods 属性缺少参数， 服务器响应400', !(done)->
    request-data =
      location:
        latitude: 123
        longitude: 123
        altitude: 123
      goods:
        gid: 'gid-1'
        #name: '哑铃'
      date: new Date!
      courier:
        name: '小明'
    request-string-data = querystring.escape JSON.stringify request-data
    request.post url + "/?" + request-string-data, !(err, res, body)->
      res.status-code.should.eql 400
      body.should.eql 'bad request'
      done!

  can '发送的请求中goods 属性id 不存在， 服务器响应400', !(done)->
    request-data =
      location:
        latitude: 123
        longitude: 123
        altitude: 123
      goods:
        #gid: 'gid-1'
        name: '哑铃'
      date: new Date!
      courier:
        name: '小明'
    request-string-data = querystring.escape JSON.stringify request-data
    request.post url + "/?" + request-string-data, !(err, res, body)->
      res.status-code.should.eql 400
      body.should.eql 'bad request'
      done!

  can '发送的请求中信息正确， 服务器响应200', !(done)->
    request-data =
      location:
        latitude: 123
        longitude: 123
        altitude: 123
      goods:
        gid: 'gid-1'
        name: '哑铃'
      date: new Date!
      courier:
        name: '小明'
    request-string-data = querystring.escape JSON.stringify request-data
    (err, res, body) <-! request.post url + "/?" + request-string-data
    res.status-code.should.eql 200
    console.log body
    done!


