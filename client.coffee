process.env.NODE_ENV ?= "development" 
process.env.agent ?= "yg"

clientGenerator = require("./NodejsClientGenerator/ClientGenerator")
client = clientGenerator.client("MessageService")

ttypes = clientGenerator.ttypes("MessageService")

user = new ttypes.UserId(
  uid: "123"
  type: "csr"
  clientType: "mobile"
)

user1 = new ttypes.UserId(
  uid: "123"
  type: "csr"
  clientType: "mobile"
)

message = new ttypes.Message(
  type: 123
  datetime: new Date().toString() 
  createdAt: Date.now()
  content: "superwolf"
  fromId: "superowlf"
)

setInterval ->
  client.online user, (err) ->
    client.sendMessageToUserIdCollection [user,user1],"message", message, (err)->
      client.offline user, (err)->
        client.sendMessage user,"message", message, (err)->
,1000