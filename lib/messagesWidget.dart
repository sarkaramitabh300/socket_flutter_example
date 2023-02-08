import 'package:flutter/material.dart';
import 'package:socket_flutter2/msg_widget/SingleMessageWidget.dart';

import 'package:socket_flutter2/msg_widget/own_msg_widget.dart';
import 'package:swipe_to/swipe_to.dart';

import 'MsgModel.dart';
import 'msg_widget/others_msg_widget.dart';

class MessagesWidget extends StatelessWidget {
  final FocusNode focusNode;
  final List<MsgModel> listMsg;
  const MessagesWidget({
    Key? key,
    required this.listMsg,
    required this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listMsg.length,
        itemBuilder: (context, index) {
          var singleMsg = listMsg[index];
          return SingleMessageWidget(
              singleMessage: singleMsg, focusNode: focusNode);
        });
  }
}
