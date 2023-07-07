class ChatUser {

//cosntructor jab bhi chatsuer banta h hamne saare field bana liye
  ChatUser({
    required this.image,
    required this.about,
    required this.name,
    required this.createdAt,
    required this.lastActive,
    required this.id,
    required this.isOnline,
    required this.email,
    required this.pushToken,
  });
  late  String image;
  late  String about;
  late  String name;
  late  String createdAt;
  late  String lastActive;
  late  String id;
  late  bool isOnline;
  late  String email;
  late  String pushToken;
  

// json data to dart mai convert krdega
  ChatUser.fromJson(Map<String, dynamic> json){
    image = json['image'] ?? '';
    about = json['about']?? '' ;
    name = json['name']?? '' ; 
    createdAt = json['created_at']?? '' ;
    lastActive = json['last_active']?? '';
    id = json['id']?? '';
    isOnline = json['is_online']?? false ;
    email = json['email']?? '';
    pushToken = json['push_token']?? '' ;
  }


//custom object ko json mai convert krdega from dart
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['about'] = about;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['last_active'] = lastActive;
    data['id'] = id;
    data['is_online'] = isOnline;
    data['email'] = email;
    data['push_token'] = pushToken;
    return data;
  }
}