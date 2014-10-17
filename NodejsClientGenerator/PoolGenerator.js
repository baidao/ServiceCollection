// Generated by CoffeeScript 1.7.1
var log, poolModule, thrift;

thrift = require('thrift');

poolModule = require('generic-pool');

log = require("./log");

exports.createCRMClientPool = function(serviceName, service, config) {
  var env, pool;
  env = process.env.NODE_ENV;
  pool = poolModule.Pool({
    name: serviceName,
    create: function(callback) {
      var client, connection;
      connection = thrift.createConnection(config.domain, config.port);
      client = thrift.createClient(service, connection);
      client.dirty_connection = connection;
      connection.once('connect', function() {
        client.isPooled = false;
        callback(null, client);
        return client.isPooled = true;
      });
      return connection.on('error', function(err) {
        if (client.isPooled) {
          pool.destroy(client);
          return log.error("" + __filename + ".inpool connnection", err);
        } else {
          callback(err);
          return log.error("" + __filename + ".create connnection", err);
        }
      });
    },
    destroy: function(client) {
      client.dirty_connection.end();
      client.dirty_connection.removeAllListeners('error');
      return client.dirty_connection = null;
    },
    max: config.max,
    min: config.min,
    idleTimeoutMillis: 30000,
    log: function(message, level) {
      return log.info({
        level: level
      }, message);
    }
  });
  return pool;
};
