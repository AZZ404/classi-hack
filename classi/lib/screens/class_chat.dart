import '../chat/chat_screen.dart';
import '../providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClassChatApp extends StatelessWidget {
  static const routeName='/class_chat';
  @override
  Widget build(BuildContext context) {
    final name=Provider.of<Auth>(context).etudiant.prenom+' '+Provider.of<Auth>(context).etudiant.nom;
    ChatScreen.category="messages";
    return  ChatScreen('Classe Chat',name,true);
  }
}
