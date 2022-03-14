import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:flutter/material.dart';

class SendButton extends StatelessWidget {
  SendButton({Key? key}) : super(key: key);
  var gkey = GlobalKey<FormState>();
  var messageTF = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      // height: 61,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35.0),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 3), blurRadius: 5, color: Colors.grey)
                ],
              ),
              child: Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.face), onPressed: () {}),
                  Expanded(
                    child: TextFormField(
                      controller: messageTF,
                      decoration: InputDecoration(
                        hintText: "Ecrire ici...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 15),
          Container(
            padding: const EdgeInsets.all(15.0),
            decoration:
                BoxDecoration(color: Colors.green, shape: BoxShape.circle),
            child: InkWell(
              child: Icon(
                Icons.send,
                color: Colors.white,
              ),
              onTap: () async {
                var txt = messageTF.text;
                if (txt.isNotEmpty) {
                  if (txt.toString().length < 250) {
                    await ctlEchange
                        .ecrireMessage(messageTF.text.toString().trim());
                    messageTF.text = '';
                  } else {
                    ctlEchange.ecrireMessage(
                        messageTF.text.toString().trim().substring(0, 250));
                    messageTF.text = '';
                  }
                }
                 FocusScope.of(context).unfocus();
              },
            ),
          )
        ],
      ),
    );
  }
}
