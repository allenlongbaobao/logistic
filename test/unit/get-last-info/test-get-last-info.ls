describe "测试获取物品的最新信息", !->
  url = config.url + '/get-last-info'
  before-each !(done)->
    utils.clean-db-and-load-fixture 'unit/get-last-info', ['goods'], done

  can "获取物品信息时，不带有gid参数，返回400", !(done)->
    request.get url + '/?', !(err, res, body)->
      res.status-code.should.eql 400
      body.should.eql 'bad request'
      done!

  can "获取物品信息时， 带有的gid 不存在， 返回400", !(done)->
    request-data =
      gid: 'not-existed-gid'
    request-string-data = querystring.stringify request-data
    request.get url + "/?" + request-string-data, !(err, res, body)->
      res.status-code.should.eql 400
      body.should.eql "bad request"
      done!

  can "获取物品信息时， 传输正确gid信息， 返回该物品的最新信息", !(done)->
    request-data =
      gid: 'gid-1'
    request-string-data = querystring.stringify request-data
    request.get url + "/?" + request-string-data, !(err, res, body)->
      res.status-code.should.eql 200
      (JSON.parse body)._id.should.eql 'gid-1'
      done!

