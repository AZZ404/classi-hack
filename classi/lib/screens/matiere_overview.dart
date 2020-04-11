import 'package:url_launcher/url_launcher.dart';

import '../providers/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MatiereOverviewScreen extends StatefulWidget {
  static const routeName='/matiere_overview';
  @override
  _MatiereOverviewScreenState createState() => _MatiereOverviewScreenState();
}

class _MatiereOverviewScreenState extends State<MatiereOverviewScreen> {
  final  List <Map<String, Object>> _pages =[
  {
    'title': 'Travail à Faire',
     'page': Travail(),
  },
  {
    'title': 'Forum',
    'page': Forum(),
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
        title: Text(ma.matieres[Data.openMatiere]),
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
              child: Image.asset('assets/img/homework.png',color: Colors.white,))  ,
            title: Text('Travail à Faire'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.deepPurple,
            icon:  Container(
              height: totalHeight*0.0373,
              child: Image.asset('assets/img/forum.png',color: Colors.white,))  ,
            title: Text('Forum'),
          ),
        ],
      ),
    );
  }
}


class Travail extends StatelessWidget {


  _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

  @override
  Widget build(BuildContext context) {
    final tr=Provider.of<Data>(context).trvails;
    final totalWidth=MediaQuery.of(context).size.width;
    return Container(
      child: tr.length==0?Center(
        child: Text('Pas de Travail pour le moment !',style:TextStyle(fontSize: 25)),
      ):
      ListView.builder(
        itemCount: tr.length,
        itemBuilder: (ctx,index){
          final x=tr[index];
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
                Image.asset('assets/img/pdf.png',height: 60,),
                Column(
                  children: <Widget>[
                    Text('${x.title}', style: TextStyle(decoration: TextDecoration.underline, color: Colors.red,fontWeight: FontWeight.bold)),
                    
                    Text('Lien : '),
                  GestureDetector(
                      child: Text(x.link, style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue)),
                      onTap: () {
                        _launchURL(x.link);
                      }
                    )
                  ],
                )
              ],
            ),
            Text(x.description)
              ],
            )
            
             
          );
        },
      ),
    );
  }
}

class Forum extends StatefulWidget {
  @override
  _ForumState createState() => _ForumState();
}

class _ForumState extends State<Forum> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child:Text('En constructoin',style: TextStyle(fontSize: 25)),
    );
  }
}