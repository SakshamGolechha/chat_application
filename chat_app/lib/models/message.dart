class Message {
  Message({
    required this.toId,
    required this.msg,
    required this.read,
    required this.type,
    required this.sent,
    required this.fromId,
    required this.isUpdated,

  });
  late final String toId;
  late final String msg;
  late final String read;
  late final Type type;
  late final String sent;
  late final String fromId;
  late final bool isUpdated;


  Message.fromJson(Map<String, dynamic> json) {
    toId = json['toId'].toString();
    msg = json['msg'].toString();
    read = json['read'].toString();
    type = json['type'].toString() == Type.image.name
        ? Type.image
        : Type.text; // to knwo what enum to use , if equal to image name
    sent = json['sent'].toString();
    fromId = json['fromId'].toString();
    isUpdated = json['is_updated']?? false ;


  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['toId'] = toId;
    data['msg'] = msg;
    data['read'] = read;
    data['type'] = type.name;
    data['sent'] = sent;
    data['fromId'] = fromId;
    data['is_updated'] = isUpdated;

    return data;
  }
}

enum Type { text, image }
