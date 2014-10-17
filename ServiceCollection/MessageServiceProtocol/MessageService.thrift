struct UserId {
  1: string uid,
  2: string type,
  3: optional string clientType
}

struct Message{
  1: i32 type,
  2: string datetime,
  3: i32 createdAt,
  4: string content,
  5: string fromId,
  6: optional string toId,
  7: optional bool isRead,
  8: optional i32 readDateTime
}


typedef list<UserId> ( cpp.template = "std::list" ) UserIdCollection


service MessageService {
  void online(1: UserId userId),
  void offline(1: UserId userId),
  void sendMessage(1: UserId userId, 2:string type, 3: Message message)
  void sendMessageToUserIdCollection(1: UserIdCollection userIdCollection, 2:string type, 3: Message message)
}