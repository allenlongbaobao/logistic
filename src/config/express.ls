require! ['express']

module.exports = !(server)->
  server.set 'port', 4000
  server.get '/', !(req, res) -> res.send 'hello world!'
  server.use express.static __dirname + '/../resource'
  server.set 'view engine', 'jade'

  # 错误处理
  server.use !(err, erq, res, next)->
    console.log "something wrong! err: ", err
    res.send 500, "Internal Server Error"
