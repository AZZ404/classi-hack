import '../providers/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import 'package:url_launcher/url_launcher.dart';



class EmploiScreen extends StatefulWidget {
static const routeName='/emploi';
  @override
  _EmploiScreenState createState() => _EmploiScreenState();
}

class _EmploiScreenState extends State<EmploiScreen> {
  final  List <Map<String, Object>> _pages =[
  {
    'title': 'Emploi',
     'page': Emploi(),
  },
  {
    'title': 'Rattrapage',
    'page': Rattrapage(),
  },
  {
    'title':'Séance En Direct',
    'page':Seance(),
  }
  
  ];

  int _selectedPageIndex=0;

    void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Emploi du Temps'),
      ),
      drawer: AppDrawer(),
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
              child: Image.asset('assets/img/emploi.png',color: Colors.white,))  ,
            title: Text('Emploi'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.deepPurple,
            icon:  Container(
              height: totalHeight*0.0373,
              child: Image.asset('assets/img/rattra.png',color: Colors.white,))  ,
            title: Text('Rattrapage'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Color.fromRGBO(2, 116, 46,1),
            icon:  Container(
              height: totalHeight*0.0373,
              child: Image.asset('assets/img/live.png',color: Colors.white,))  ,
            title: Text('Séance En Direct'),
          ),
        ],
      ),
    );
  }
}



class Emploi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Divider(thickness: 3,),
          Text('Lundi',style: TextStyle(color: Colors.blue,fontSize: 24,fontWeight: FontWeight.bold),),
          Divider(thickness: 3),
          Image.network('https://imgur.com/PVaaSwm.png'),
           Divider(thickness: 3),
          Text('Mardi',style: TextStyle(color: Colors.blue,fontSize: 24,fontWeight: FontWeight.bold),),
          Divider(thickness: 3),
          Image.network('https://imgur.com/C9XkLeE.png'),
           Divider(thickness: 3),
          Text('Mercredi',style: TextStyle(color: Colors.blue,fontSize: 24,fontWeight: FontWeight.bold),),
          Divider(thickness: 3),
          Image.network('https://imgur.com/MxnbuXK.png'),
           Divider(thickness: 3),
          Text('Jeudi',style: TextStyle(color: Colors.blue,fontSize: 24,fontWeight: FontWeight.bold),),
          Divider(thickness: 3),
          Image.network('https://imgur.com/DfHwPU4.png'),
           Divider(thickness: 3),
          Text('Vendredi',style: TextStyle(color: Colors.blue,fontSize: 24,fontWeight: FontWeight.bold),),
          Divider(thickness: 3),
          Image.network("https://imgur.com/MrP1w3K.png"),
           Divider(thickness: 3),
          Text('Samedi',style: TextStyle(color: Colors.blue,fontSize: 24,fontWeight: FontWeight.bold),),
          Divider(thickness: 3),
          Image.network('https://imgur.com/cMBtgNl.png'),
        ],
      ),
    );
  }
}


class Rattrapage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Divider(thickness: 3,),
          Text('Lundi',style: TextStyle(color: Colors.blue,fontSize: 24,fontWeight: FontWeight.bold),),
          Divider(thickness: 3),
          Image.network('https://i.imgur.com/KjSUPbO.png',height: 50,),
           Divider(thickness: 3),
          Text('Mardi',style: TextStyle(color: Colors.blue,fontSize: 24,fontWeight: FontWeight.bold),),
          Divider(thickness: 3),
          Image.network('https://imgur.com/KjSUPbO.png',height: 50),
           Divider(thickness: 3),
          Text('Mercredi',style: TextStyle(color: Colors.blue,fontSize: 24,fontWeight: FontWeight.bold),),
          Divider(thickness: 3),
          Image.network('https://imgur.com/KjSUPbO.png',height: 50),
           Divider(thickness: 3),
          Text('Jeudi',style: TextStyle(color: Colors.blue,fontSize: 24,fontWeight: FontWeight.bold),),
          Divider(thickness: 3),
          Image.network('https://imgur.com/KjSUPbO.png',height: 50),
           Divider(thickness: 3),
          Text('Vendredi',style: TextStyle(color: Colors.blue,fontSize: 24,fontWeight: FontWeight.bold),),
          Divider(thickness: 3),
          Image.network("https://imgur.com/KjSUPbO.png",height: 50),
           Divider(thickness: 3),
          Text('Samedi',style: TextStyle(color: Colors.blue,fontSize: 24,fontWeight: FontWeight.bold),),
          Divider(thickness: 3),
          Image.network('https://imgur.com/KjSUPbO.png',height: 50),
        ],
      ),
    );
  }
}


class Seance extends StatelessWidget {


  _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

  @override
  Widget build(BuildContext context) {
    final totalWidth=MediaQuery.of(context).size.width;
    final se=Provider.of<Data>(context);
    return Container(
      child:  se.seances.length==0?Center(
         child: Text('Pas de seances pour le moment',style: TextStyle(color: Colors.black,fontSize: 25),),
       ):ListView.builder(
        itemCount: se.seances.length,
        itemBuilder: (ctx,index)
        {
          final x=se.seances[index];
          return Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(width:4,color:Colors.purple),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white.withOpacity(0.5)
            ),
            height: 100,

            width: totalWidth*0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset('assets/img/teams.png',height: 80,),
                Column(
                  children: <Widget>[
                    Text('Matiere : ${x.matiere}', style: TextStyle(decoration: TextDecoration.underline, color: Colors.red)),
                    Text('Date : ${x.date}'),
                    Text('Heure : ${x.heure}'),
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
            )
          );
        }
      ),
    );
  }
}