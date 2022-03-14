import 'package:alfred_taxi_driver/app/modules/chatbox/views/messenger.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/chatbox_controller.dart';

class ChatboxView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Echange avec le client'),
          centerTitle: true,
        ),
        body: ChatScreen());
  }
}




/* 
import 'package:alfred_taxi_driver/app/modules/chatbox/controllers/global.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'receivedmessagewidget.dart';
import 'send_button.dart';
import 'sentmessagewidget.dart';

class ChatboxView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
          child: StreamBuilder(
        initialData: null,
        // stream: _stream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var temp = snapshot.hasData as Future<dynamic>;
            return Column(
              children: [
                CupertinoButton(
                  child: const Text("FERMER"),
                  onPressed: () => Get.back(),
                ),
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.all(15),
                    itemCount: messages.length,
                    itemBuilder: (ctx, i) {
                      if (messages[i]['status'] == MessageType.received) {
                        return ReceivedMessagesWidget(i: i);
                      } else {
                        return SentMessageWidget(i: i);
                      }
                    },
                  ),
                ),
                const SendButton(),
              ],
            );
          } else {
            return Column(
              children: [
                CupertinoButton(
                  child: const Text("FERMER"),
                  onPressed: () => Get.back(),
                ),
                Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            );
          }
        },
      )),
    );
  }

  Stream _stream() {
    Duration interval = Duration(seconds: 1);
    Stream stream = Stream.periodic(interval, _getData());
    return stream;
  }

  // Future<List<dynamic>> _getData(int value) async {
  //   var res =
  //       await http.post('http://192.168.1.107/chat/api/get_mess.php', body: {
  //     'username': widget.user.username,
  //     'password': widget.user.password,
  //     'user_to': widget.userTo.username
  //   });
  //   var jsonx = json.decode(res.body);
  //   return jsonx;
  // }

  // _sendMess(String content) async {
  //   var res =
  //       await http.post('http://192.168.1.107/chat/api/send_mess.php', body: {
  //     'username': widget.user.username,
  //     'password': widget.user.password,
  //     'user_to': widget.userTo.username,
  //     'content': content
  //   });
  //   return res.body;
  // }

  _getData() {
    return friendsList;
  }

  Get.snackbar(
                    "Nouveau message",
                    "Je suis au feu du chu, devant la boutique à....",
                    isDismissible: false,
                    onTap: (snack) {
                      ctlChatbox.UNREDMESSAGE.value = true;
                      ctlcommande.statuscommand.value = STATUS.COMMAND_ACCEPTED;
                      Get.toNamed(Routes.DRIVER_MAP);
                    },
                    icon: InkWell(
                      onTap: () {
                        ctlChatbox.UNREDMESSAGE.value = true;
                        ctlcommande.statuscommand.value =
                            STATUS.COMMAND_ACCEPTED;
                        Get.toNamed(Routes.DRIVER_MAP);
                      },
                      child: Icon(Icons.open_in_new),
                    ),
                  ),
}
 */