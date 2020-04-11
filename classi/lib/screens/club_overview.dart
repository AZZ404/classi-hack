import 'package:classi/chat/chat_screen.dart';
import 'package:classi/providers/auth.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ClubOverviewScreen extends StatefulWidget {
  static const routeName='/club_overview';
  @override
  _ClubOverviewScreenState createState() => _ClubOverviewScreenState();
}

class _ClubOverviewScreenState extends State<ClubOverviewScreen> {
  final  List <Map<String, Object>> _pages =[
  {
    'title': 'Evenements',
     'page': Events(),
  },
  {
    'title': 'Chat',
    'page': Chat(),
  },];


  int _selectedPageIndex=0;
    void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalHeight=MediaQuery.of(context).size.height;
    final ma=Provider.of<Data>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(ma.clubs[Data.openClub]),
      ),
      body:SafeArea(child:_pages[_selectedPageIndex]['page'] ,),
      bottomNavigationBar: BottomNavigationBar(
        
        onTap: _selectPage,
        backgroundColor: Colors.blueGrey,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Color.fromRGBO(2, 116, 46,1),
            icon:  Container(
              height: totalHeight*0.0373,
              child: Image.asset('assets/img/event.png',color: Colors.white,))  ,
            title: Text('Evenements'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.deepPurple,
            icon:  Container(
              height: totalHeight*0.0373,
              child: Image.asset('assets/img/chat.png',color: Colors.white,))  ,
            title: Text('Chat'),
          ),
        ],
      ),
    );
  }
}


class Events extends StatelessWidget {


  _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

  @override
  Widget build(BuildContext context) {
    final ev=Provider.of<Data>(context).events;
    final totalWidth=MediaQuery.of(context).size.width;
    return Container(
      child: ev.length==0?Center(
        child: Text('Pas d\'évenements pour le moment !',style:TextStyle(fontSize: 25),textAlign: TextAlign.center,),
      ):
      ListView.builder(
        itemCount: ev.length,
        itemBuilder: (ctx,index){
          final x=ev[index];
          return Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(width:4,color:Colors.purple.withOpacity(0.7)),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white.withOpacity(0.5)
            ),
            //height: 100,

            width: totalWidth*0.9,
            child:Column(
              children: <Widget>[
                Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset('assets/img/log.png',height: 60,),
                Column(
                  children: <Widget>[
                    Text('${x.title}', style: TextStyle(decoration: TextDecoration.underline, color: Colors.red,fontWeight: FontWeight.bold)),
                    Text('date : ${x.date}'),
                    Text('Heure : ${x.heure}'),
                    Text('Place : ${x.place}'),
                  ],
                )
              ],
            ),
            SizedBox(height: 10,),
            Text(x.description)
              ],
            )
          );
        },
      ),
    );
  }
}

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
        final ma=Provider.of<Data>(context);
    final name=Provider.of<Auth>(context).etudiant.prenom+' '+Provider.of<Auth>(context).etudiant.nom;
    ChatScreen.category=ma.clubs[Data.openClub];
    return  ChatScreen('Classe Chat',name,false);
   
  }
}