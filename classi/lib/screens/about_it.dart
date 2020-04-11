import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../widgets/moazmar_logo.dart';
class AboutIt extends StatelessWidget {
  static const routeName = '/about-it';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('About It'),
      ),
      drawer: AppDrawer(),
      body:Container(
        decoration: BoxDecoration(
          gradient:LinearGradient(begin: Alignment.topCenter,end:Alignment.bottomRight,colors: [
          Color.fromRGBO(238, 9, 121, 1),
          Color.fromRGBO(255, 106, 0,1),
        ]),),
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('Hackthon Ched Darek ',style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold,color: Colors.white),),
              Text('Classi !',style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold,color: Colors.white,fontStyle: FontStyle.italic),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Made With ',style: TextStyle(fontSize: 22,color:Colors.white, fontWeight: FontWeight.bold)),
                   Container(
                     padding: EdgeInsets.all(5),
                  height: 70,
                   decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color:Colors.white,width:1),
                        color: Colors.white.withOpacity(0.05) ,
                        ),
                  child:Image.asset('assets/img/flutter.png', fit: BoxFit.cover)
                ),
                  Text(' And ',style: TextStyle(fontSize: 22,color:Colors.white, fontWeight: FontWeight.bold)),

                Container(
                  height: 70,
                   decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color:Colors.white,width:1),
                        color: Colors.white.withOpacity(0.05) ,
                        ),
                  child:Image.asset('assets/img/firebase.png', fit: BoxFit.fill)
                )
                
                ],
              )
              
              ,Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('P',style: TextStyle(fontSize: 24, color:Colors.yellow,fontWeight: FontWeight.bold)),
                  Text('owered ',style: TextStyle(fontSize: 24,color:Colors.white, fontWeight: FontWeight.bold)),
                  Text('B',style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color:Colors.yellow)),
                  Text('y   ',style: TextStyle(fontSize: 24,color:Colors.white, fontWeight: FontWeight.bold)),
                  MoAzMarLogo()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}