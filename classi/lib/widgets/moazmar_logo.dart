import 'package:flutter/material.dart';
class MoAzMarLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 10,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal:20, vertical:5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color:Colors.white.withOpacity(0.5),width:1),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.pink,
              Colors.purple,
              Colors.blue,
            ]
          )
        ),
        child: Text('MoAzMar',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Pacifico'))),
    );
  }
}


