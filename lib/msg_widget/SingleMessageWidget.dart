import 'package:flutter/material.dart';

import '../Constants.dart';
import '../MsgModel.dart';
import 'package:swipe_to/swipe_to.dart';

import 'others_msg_widget.dart';
import 'own_msg_widget.dart';

// https://www.youtube.com/watch?v=ojBSygkVaNo&t=97s&ab_channel=HeyFlutter
// https://www.youtube.com/watch?v=wHIcJDQbBFs&t=0s&ab_channel=HeyFlutter
class SingleMessageWidget extends StatelessWidget {
  final MsgModel singleMessage;

  final FocusNode focusNode;
  final messageReply;
  final VoidCallback onCancleReply;

  const SingleMessageWidget(
      {Key? key, required this.singleMessage, required this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (singleMessage.type == Constants.OWN_MSG) {
      return SwipeTo(
          onRightSwipe: () {
            focusNode.requestFocus();
          },
          child: OwnMsgWidget(
              sender: singleMessage.sender, msg: singleMessage.msg));
    } else {
      return SwipeTo(
          onRightSwipe: () {
            focusNode.requestFocus();
          },
          child: OtherMsgWidget(
              sender: singleMessage.sender, msg: singleMessage.msg));
    }
  }
}
