import '../screens/class_chat.dart';
import '../screens/contact_prof.dart';
import '../screens/profile.dart';

import '../screens/clubs.dart';
import '../screens/emploi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/matiere.dart';
import '../screens/news.dart';
import '../screens/about_it.dart';
import '../providers/auth.dart';


class AppDrawer extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AppBar(
              title: Text('Classi !'),
              automaticallyImplyLeading: false,
            ),
            Divider(),
            ListTile(
              leading: Image.asset('assets/img/news.png',height: 30,),
              title: Text('Actualités'),
              onTap: (){
                Navigator.of(context).pushReplacementNamed(NewsScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Container(height: 30,child: Image.asset('assets/img/emploi.png')),
              title: Text('Emploi du Temps'),
              onTap: (){
                Navigator.of(context).pushReplacementNamed(EmploiScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Image.asset('assets/img/matiere.png',height: 30),
              title: Text('Matières'),
              onTap: (){
                Navigator.of(context).pushReplacementNamed(MatiereScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Image.asset('assets/img/club.png',height: 30),
              title: Text('Clubs'),
              onTap: (){
               Navigator.of(context).pushReplacementNamed(ClubsScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Image.asset('assets/img/chat.png',height: 30),
              title: Text('Class Chat'),
              onTap: (){
                Navigator.of(context).pushReplacementNamed(ClassChatApp.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Image.asset('assets/img/prof.png',height: 30),
              title: Text('Contacter un Prof'),
              onTap: (){
                 Navigator.of(context).pushReplacementNamed(ProfScreen.routeName);
              },
            ),

            Divider(),
            ListTile(
              leading: Icon(Icons.person_pin,size: 30),
              title: Text('My Profile'),
              onTap: (){
                Navigator.of(context).pushReplacementNamed(MyProfile.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app,size: 30,),
              title: Text('Log Out'),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/');
                Provider.of<Auth>(context, listen: false).logout();

              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.help,size: 30,),
              title: Text('About It'),
              onTap: (){
                Navigator.of(context).pushReplacementNamed(AboutIt.routeName);
              },
            )
          ],
        ),
      ),
    );
  }
}