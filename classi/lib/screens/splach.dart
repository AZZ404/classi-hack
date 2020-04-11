import 'package:flutter/material.dart';
import 'dart:math';
import '../widgets/moazmar_logo.dart';
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    /*Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                    Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),*/
                    Color.fromRGBO(238, 9, 121, 1),
                    Color.fromRGBO(255, 106, 0,1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  //stops: [0, 1],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                height: deviceSize.height,
                width: deviceSize.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 45,),
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20.0),
                        padding:
                            EdgeInsets.symmetric(vertical: 8.0, horizontal: 94.0),
                        transform: Matrix4.rotationZ(-8 * pi / 180)
                          ..translate(-10.0),
                        // ..translate(-10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue.shade900,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8,
                              color: Colors.black45,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: Text(
                          'Mo Store',
                          style: TextStyle(
                            color: Theme.of(context).accentTextTheme.title.color,
                            fontSize: 40,
                            fontFamily: 'Anton',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: deviceSize.width > 600 ? 2 : 2,
                      child: Center(child: Container(
                        padding: EdgeInsets.symmetric(horizontal:deviceSize.width*0.25,vertical:5),
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius:BorderRadius.circular(15), 
                          border: Border.all(color: Colors.white,width: 1)
                        ),
                        child: Text("Loading ...",style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontFamily: 'Anton',
                              fontWeight: FontWeight.normal,
                            )),
                      )),
                    ),
                    if(MediaQuery.of(context).orientation==Orientation.portrait)
                      Container(
                        margin:EdgeInsets.only(top:50),
                        alignment: Alignment.centerRight,
                        child: MoAzMarLogo())
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
