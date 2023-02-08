import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'Constants.dart';
import 'MsgModel.dart';
import 'messagesWidget.dart';
import 'msg_widget/others_msg_widget.dart';

class ChatPage extends StatefulWidget {
  final String name;
  final String userId;

  const ChatPage({Key? key, required this.name, required this.userId})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textController = TextEditingController();
  IO.Socket? socket;
  List<MsgModel> listMsg = [];
  final focusNode = FocusNode();

  late final ValueChanged<MsgModel> onSwippedMsg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Column(
        children: [
          Expanded(
              child: MessagesWidget(
            focusNode: focusNode,
            listMsg: listMsg,
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                  controller: _textController,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    hintText: "Type here...",
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      borderSide: BorderSide(width: 2),
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          sendMsg(_textController.text, widget.name);
                          _textController.clear();
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.blue,
                          size: 26,
                        )),
                  ),
                )),
              ],
            ),
          )
        ],
      ),
    );
  }

  void sendMsg(String msg, String senderName) {
    print("sendMsg($msg,$senderName)");
    MsgModel msgModel =
        MsgModel(msg: msg, type: Constants.OWN_MSG, sender: senderName);
    listMsg.add(msgModel);
    setState(() {
      listMsg;
    });
    socket!.emit('sendMsg', {
      'type': "ownMsg",
      "msg": msg,
      "senderName": senderName,
      "userId": widget.userId
    });
  }

  @override
  void initState() {
    // textController=textController
    socket = IO.io('http://localhost:3000', <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket!.connect();
    socket!.onConnect((_) {
      print('connect');
      socket!.emit('message', 'test');

      socket!.on('sendMsgServer', (msg) {
        print("sendMsgServer- $msg");
        if (msg["userId"] != widget.userId) {
          listMsg.add(MsgModel(
              msg: msg["msg"], type: msg["type"], sender: msg["senderName"]));

          setState(() {
            listMsg;
          });
        }
      });
    });
  }
}
