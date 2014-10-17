buildPoolMethod = (serviceName, service, config)->
  poolClient = {}
  crmClientPool = require('./PoolGenerator').createCRMClientPool(serviceName, service, config)
  filterMethod = ->
    prop for prop in Object.keys service.Client.prototype when prop.indexOf('send_') is -1 and prop.indexOf('recv_') is -1

  filterMethod().map (method)->
    poolClient[method] = ->
      _args = Array.prototype.slice.call arguments
      crmClientPool.acquire (err, client)->
        if typeof _args[_args.length-1] is 'function'
          _callback = _args[_args.length-1]
        else
          _callback = ->
          _args.push _callback

        if err
          console.error "#{__filename}.acquire #{method} ", err
          _callback err
          return

        callback = ->
          crmClientPool.release client
          _callback.apply null, arguments

        _args[_args.length-1] = callback

        client[method].apply client, _args

  poolClient

exportClient = {}
module.exports = 
  client: (serviceName)->
    service = require("../ServiceCollection/#{serviceName}Protocol/gen-nodejs/MessageService")
    config = require("../ServiceCollection/#{serviceName}Protocol/config")
    unless exportClient[serviceName] 
      exportClient[serviceName]  = buildPoolMethod(serviceName, service, config)
    exportClient[serviceName] 
  ttypes: (serviceName)->
    require("../ServiceCollection/#{serviceName}Protocol/gen-nodejs/MessageService_types")