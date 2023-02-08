/// type : ""
/// msg : ""
/// userName : ""
/// userId : ""
/// createdAt : ""
/// groupId : ""

class MessageModel {
  MessageModel({
    String? type,
    String? msg,
    String? userName,
    String? userId,
    String? createdAt,
    String? groupId,
  }) {
    _type = type;
    _msg = msg;
    _userName = userName;
    _userId = userId;
    _createdAt = createdAt;
    _groupId = groupId;
  }

  MessageModel.fromJson(dynamic json) {
    _type = json['type'];
    _msg = json['msg'];
    _userName = json['userName'];
    _userId = json['userId'];
    _createdAt = json['createdAt'];
    _groupId = json['groupId'];
  }
  String? _type;
  String? _msg;
  String? _userName;
  String? _userId;
  String? _createdAt;
  String? _groupId;
  MessageModel copyWith({
    String? type,
    String? msg,
    String? userName,
    String? userId,
    String? createdAt,
    String? groupId,
  }) =>
      MessageModel(
        type: type ?? _type,
        msg: msg ?? _msg,
        userName: userName ?? _userName,
        userId: userId ?? _userId,
        createdAt: createdAt ?? _createdAt,
        groupId: groupId ?? _groupId,
      );
  String? get type => _type;
  String? get msg => _msg;
  String? get userName => _userName;
  String? get userId => _userId;
  String? get createdAt => _createdAt;
  String? get groupId => _groupId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['msg'] = _msg;
    map['userName'] = _userName;
    map['userId'] = _userId;
    map['createdAt'] = _createdAt;
    map['groupId'] = _groupId;
    return map;
  }
}
