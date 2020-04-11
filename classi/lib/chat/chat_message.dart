import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final String imageUrl;
  final String username;
  final AnimationController animationController;

  ChatMessage(
    {
      this.text,
    this.imageUrl,
    this.username,
    this.animationController
    }
  );

  Map<String, dynamic> toMap() => imageUrl == null
      ? {'text': text, 'username': username}
      : {'imageUrl': imageUrl, 'username': username};

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        axisAlignment: 0.0,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: CircleAvatar(child: Text(username[0].toUpperCase())),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(username, style: TextStyle(
                        color: Colors.grey,fontSize: 12
                    )),
                    Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: imageUrl == null
                          ? Text(text)
                          : Image.network(imageUrl),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
