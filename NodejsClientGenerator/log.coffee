bunyan = require("bunyan")
path = require("path")

logDir = path.join __dirname, "../log"
log = bunyan.createLogger
  name: 'regular'
  streams: [
    {
      level: 'info',
      stream: process.stdout
    }
    {
      level: 'error'
      type: 'rotating-file'
      path: "#{logDir}/error.log"
      period: '1d'
      count: 10
    }
  ]

module.exports = log