import 'dart:async';

import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:alfred_taxi_driver/app/modules/chatbox/views/send_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'sent_message_widget.dart';
import 'received_message_wisget.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _showBottom = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedBox(
          height: 70.h,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Obx(() => ListView(
                      reverse: true,
                      padding: const EdgeInsets.all(15),
                      children: [
                        for (var i = 0; i < ctlEchange.chatboxList.length; i++)
                          ctlEchange.chatboxList[i].driverId ==
                                  ctlHome.driver.value.id
                              ? ReceivedMessagesWidget(
                                  message: ctlEchange.chatboxList[i].contenu)
                              : SentMessageWidget(
                                  message: ctlEchange.chatboxList[i].contenu)
                      ],
                    )),
              ),
            ],
          ),
        ),
        Align(alignment: Alignment.bottomCenter, child: SendButton()),
      ],
    );
  }
}
