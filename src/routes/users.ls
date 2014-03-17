require! ['../controllers/users']
module.exports = !(app)->
  app.post '/login', users.verify-request-data, users.login
  app.post '/register', users.register

  #TODO
  #给电商的接口
  #1. add-goods
  #2. accept-goods
