
describe '测试登录', !->
  url = config.url + '/login'
  before-each !(done)->
    utils.clean-db-and-load-fixture 'unit/login', ['users'], done

  can '提供错误的邮箱， 返回400', !(done)->
    info =
      email: '12314'
      password: '123456'
    request-string-data = querystring.stringify info
    (err, res, body) <-! request.post url + '?' + request-string-data
    res.status-code.should.eql 400
    done!

  can '提供长度不正确的密码， 返回400', !(done)->
    info =
      email: 'a@gmail.com'
      password: '1'
    request-string-data = querystring.stringify info
    (err, res, body) <-! request.post url + '?' + request-string-data
    res.status-code.should.eql 400
    done!

  can '提供的密码所对应的用户不存在， 返回400', !(done)->
    info =
      email: 'b@gmail.com'
      password: '123456'
    request-string-data = querystring.stringify info
    (err, res, body) <-! request.post url + '?' + request-string-data
    res.status-code.should.eql 400
    done!


  can '提供正确的信息， 返回200', !(done)->
    info =
      email: 'a@gmail.com'
      password: '123456'
    request-string-data = querystring.stringify info
    (err, res, body) <-! request.post url + '?' + request-string-data
    res.status-code.should.eql 200
    done!
