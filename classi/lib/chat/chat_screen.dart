import 'dart:io';

import '../widgets/app_drawer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './chat_message.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';


class ChatScreen extends StatefulWidget {
  final String name;
  static String category;
  final bool showBar;
  ChatScreen(String title,this.name, this.showBar,{Key key, this.userId,})
      : _title = title,
        super(key: key);

  final _title;
  final String userId;

  @override
  State createState() => ChatScreenState(_title);
}


class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final _title;
  final List<ChatMessage> _messages;
  final TextEditingController _textController;
  final DatabaseReference _messageDatabaseReference;
  final StorageReference _photoStorageReference;

  bool _isComposing = false;

  ChatScreenState(String title)
      : _title = title,
        _isComposing = false,
        _messages = <ChatMessage>[],
        _textController = TextEditingController(),
        _messageDatabaseReference =
            FirebaseDatabase.instance.reference().child(ChatScreen.category),
        _photoStorageReference =
            FirebaseStorage.instance.ref().child("chat_photos") {
    _messageDatabaseReference.onChildAdded.listen(_onMessageAdded);
  }

  Widget _buildTextComposer() {
    return IconTheme(
        data: IconThemeData(color: Theme.of(context).accentColor),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  controller: _textController,
                  onChanged: (String text) {
                    setState(() {
                      _isComposing = text.length > 0;
                    });
                  },
                  onSubmitted: _handleSubmitted,
                  decoration:
                      InputDecoration.collapsed(hintText: "Send a message"),
                ),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: _sendImageFromCamera,
                      ),
                      IconButton(
                        icon: Icon(Icons.image),
                        onPressed: _sendImageFromGallery,
                      ),
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? CupertinoButton(
                              child: Text("Send"),
                              onPressed: _isComposing
                                  ? () => _handleSubmitted(_textController.text)
                                  : null,
                            )
                          : IconButton(
                              icon: Icon(Icons.send),
                              onPressed: _isComposing
                                  ? () => _handleSubmitted(_textController.text)
                                  : null,
                            ),
                    ],
                  ))
            ],
          ),
        ));
  }

  void _onMessageAdded(Event event) {
    final text = event.snapshot.value["text"];
    final imageUrl = event.snapshot.value["imageUrl"];
    final username=event.snapshot.value["username"];

    ChatMessage message = imageUrl == null
        ? _createMessageFromText(text,username)
        : _createMessageFromImage(imageUrl,username);

    setState(() {
      _messages.insert(0, message);
    });

    message.animationController.forward();
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });

    final ChatMessage message = _createMessageFromText(text,widget.name);
    _messageDatabaseReference.push().set(message.toMap());
  }

  void _sendImage(ImageSource imageSource) async {
    File image = await ImagePicker.pickImage(source: imageSource);
    final String fileName = Uuid().v4();
    StorageReference photoRef = _photoStorageReference.child(fileName);
    final StorageUploadTask uploadTask = photoRef.putFile(image);
    final StorageTaskSnapshot downloadUrl = await uploadTask.onComplete;
    final ChatMessage message = _createMessageFromImage(
      await downloadUrl.ref.getDownloadURL(),widget.name
    );
    _messageDatabaseReference.push().set(message.toMap());
  }

  void _sendImageFromCamera() async {
    _sendImage(ImageSource.camera);
  }

  void _sendImageFromGallery() async {
    _sendImage(ImageSource.gallery);
  }

  ChatMessage _createMessageFromText(String text,String name) => ChatMessage(
        text:text,
        username:name,
        animationController:AnimationController(
          duration: Duration(milliseconds: 180),
          vsync: this,
        ),
      );

  ChatMessage _createMessageFromImage(String imageUrl,String name) => ChatMessage(
        imageUrl: imageUrl,
        username: name,
        animationController: AnimationController(
          duration: Duration(milliseconds: 90),
          vsync: this,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showBar?AppBar(
        title: Text(_title),
      ):null,
      drawer: widget.showBar?AppDrawer():null,
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                padding: EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (_, int index) => _messages[index],
                itemCount: _messages.length,
              ),
            ),
            Divider(height: 1.0),
            Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            ),
          ],
        ),
        decoration: Theme.of(context).platform == TargetPlatform.iOS
            ? BoxDecoration(
                border: Border(
                top: BorderSide(color: Colors.grey[200]),
              ))
            : null,
      ),
    );
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages)
      message.animationController.dispose();
    super.dispose();
  }





}
