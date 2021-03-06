module.exports =    
  development:
    domain: "localhost"
    port: 11000
    max: 10
    # optional. if you set this, make sure to drain() (see step 3)
    min: 0
    # specifies how long a resource can stay idle in pool before being removed
    idleTimeoutMillis: 30000
    # if true, logs via console.log - can also be a function
    log: true
    transport: "TBufferedTransport"

  test: 
    domain: "127.0.0.1"
    port: 11000
    max: 10
    # optinal. if you set this, make sure to drain() (see step 3)
    min: 2
    # specifies how long a resource can stay idle in pool before being removed
    idleTimeoutMillis: 30000
    # if true, logs via console.log - can also be a function
    log: false
    transport: "TBufferedTransport"
    
  integration: 
    domain: "192.168.26.90"
    port: 11000
    max: 10
    # optinal. if you set this, make sure to drain() (see step 3)
    min: 2
    # specifies how long a resource can stay idle in pool before being removed
    idleTimeoutMillis: 30000
    # if true, logs via console.log - can also be a function
    log: false    
    transport: "TBufferedTransport"

  production:
    domain: "Chat-TT-110.ytx.com"
    port: 11000
    max: 100
    # optinal. if you set this, make sure to drain() (see step 3)
    min: 20
    # specifies how long a resource can stay idle in pool before being removed
    idleTimeoutMillis: 30000
    # if true, logs via console.log - can also be a function
    log: true
    transport: "TBufferedTransport"