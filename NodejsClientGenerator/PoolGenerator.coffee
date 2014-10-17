thrift = require('thrift')
poolModule = require('generic-pool')
log = require("./log")

exports.createCRMClientPool = (serviceName, service, config)->
  env = process.env.NODE_ENV
  pool = poolModule.Pool
    name: serviceName
    create: (callback) ->
      connection = thrift.createConnection config.domain, config.port

      client = thrift.createClient service, connection
      client.dirty_connection = connection

      connection.once 'connect', -> 
        client.isPooled = false
        callback(null, client)
        client.isPooled = true

      connection.on 'error', (err)-> 
        if client.isPooled
          pool.destroy client
          log.error "#{__filename}.inpool connnection", err
        else
          callback err
          log.error "#{__filename}.create connnection", err

    destroy: (client) ->
      client.dirty_connection.end()
      client.dirty_connection.removeAllListeners('error')
      client.dirty_connection = null

    max: config.max
    # optional. if you set this, make sure to drain() (see step 3)
    min: config.min
    # specifies how long a resource can stay idle in pool before being removed
    idleTimeoutMillis: 30000
    # if true, logs via console.log - can also be a function
    log: (message, level)-> log.info({level:level},message)

  pool


