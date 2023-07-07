import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/helper/my_date_util.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/dialogs/profile_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../api/apis.dart';
import '../main.dart';
import '../models/chat_user.dart';
import '../screens/chat_screen.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;

  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  //last message info (if null => no message)
  Message? _message;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(horizontal: mq.width * 0.04, vertical: 4),
        elevation: 0.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ChatScreen(user: widget.user)));
          },
          child: StreamBuilder(
            stream: APIs.getLastMessage(widget.user),
            builder: (context, AsyncSnapshot snapshot) {
              final data = snapshot.data?.docs;

              final list = data
                      ?.map<Message>((e) => Message.fromJson(e.data()))
                      .toList() ??
                  [];

              if (list.isNotEmpty) {
                _message = list[0];
              }

              return ListTile(
                //profile picture of user
                leading: InkWell(
                  onTap : ( ){
                    showDialog(context: context, builder: (_)=> ProfileDialog(user: widget.user));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(mq.height * .3),
                    child: CachedNetworkImage(
                      width: mq.height * .055,
                      height: mq.height * 0.055,
                      imageUrl: widget.user.image,
                      //placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const CircleAvatar(
                        child: Icon(CupertinoIcons.person),
                      ),
                    ),
                  ),
                ),

                //name of user
                title: Text(widget.user.name),

                //last message
                subtitle: Text(
                    _message != null ? 
                    _message!.type==Type.image ?
                     'Sent you an image!'
                    :
                    _message!.msg : widget.user.about,
                    maxLines: 1),

                //last msg time
                trailing: _message==null ? null   //show nothing if no convo has ever happened
                :
                   _message!.read.isEmpty && _message!.fromId!=APIs.user.uid?   //checking if we are last sneder then only show msg without green icon
                  Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent.shade400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ) : Text(
               MyDateUtil.getLastMessageTime(context: context, time: _message!.sent),
               style: TextStyle(color: Colors.black54),
            ),
              );
            },
            // trailing: Text(
            //   '12:00 PM',
            //   style: TextStyle(color: Colors.black54),
            // ),
          ),
        ));
  }
}
