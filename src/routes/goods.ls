require! ['../controllers/goods', '../utils/database']

module.exports = !(app)->

  app.post '/send-info', goods.verify-request-data, goods.send-info
  app.get '/get-last-info', goods.get-last-info
  app.get '/get-all-infos', goods.get-all-infos

  #TODO
  # 服务器向android 端推送信息，暂定用socket.io



