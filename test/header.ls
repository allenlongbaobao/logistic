debug = require('debug')('logistic-follower')
require! [http, should, request, '../../bin/config/config', '../helper']

base-url = "http://localhost:#{config.port}"

can = it


