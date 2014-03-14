debug = require('debug')('logistic-follower')
require! [querystring, http, should, request, '../../../bin/config/config', '../../utils']

base-url = "http://localhost:#{config.port}"

can = it


