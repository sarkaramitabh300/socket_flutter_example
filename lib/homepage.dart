import 'package:flutter/material.dart';


import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'MsgModel.dart';

class HomePage extends StatefulWidget {
  final String name;
  const HomePage({Key? key, required this.name}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _textController = TextEditingController();
  IO.Socket? socket;
  List<MsgModel> listMsg = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Socket"),
      ),
      body: Column(
        children: [
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                  controller: _textController,
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
                          sendMsg(_textController.text, "Amitabh");
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
 socket!.emit('sendMsg', {
      'type': "ownMsg",
      "msg": msg,
      "senderName": senderName,
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
    });
    // socket.on('message', (data) => print(data));
    // socket.onDisconnect((_) => print('disconnect'));
    // socket.on('fromServer', (_) => print(_));
  }
}
