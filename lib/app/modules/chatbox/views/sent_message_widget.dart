import 'package:flutter/material.dart';

class SentMessageWidget extends StatelessWidget {
  final message;

  const SentMessageWidget({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "client",
                style: Theme.of(context).textTheme.caption,
              ),
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * .6),
                padding: const EdgeInsets.all(15.0),
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    topRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                ),
                child:
                    Text("${message}", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          const SizedBox(width: 15),
          // Text(
          //   "}",
          //   // style: Theme.of(context).textTheme.body2.apply(color: Colors.grey),
          // ),
        ],
      ),
    );
  }
}
