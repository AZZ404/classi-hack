import 'package:classi/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';

import '../providers/data.dart';
import '../widgets/webview.dart';



class NewsScreen  extends StatefulWidget {
  static const routeName ='/news-overview';
  @override
  _NewsScreenState createState() => _NewsScreenState();
  
}

class _NewsScreenState extends State<NewsScreen> {
     final  List <Map<String, Object>> _pages =[
  {
    'title': 'Admnistration',
     'page': Admin(),
  },
  {
    'title': 'Professeurs',
    'page': Profs(),
  },];


  int _selectedPageIndex=0;
    void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }
  bool loadData=false;
  @override
  Widget build(BuildContext context) {
    if(!loadData){
      Provider.of<Auth>(context).fetchAndSetData();
      loadData=true;
    }
    double totalHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualités'),
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
              child: Image.asset('assets/img/admin.png',color: Colors.white,))  ,
            title: Text('Administration'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.deepPurple,
            icon:  Container(
              height: totalHeight*0.0373,
              child: Image.asset('assets/img/prof.png',color: Colors.white,))  ,
            title: Text('Professeurs'),
          ),
        ],
      ),
    );
  }
}

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: WebViewContainer('http://www.issatso.rnu.tn/fo/actualites.php'),
    );
}
}


class Profs extends StatefulWidget {
  @override
  _ProfsState createState() => _ProfsState();
}

class _ProfsState extends State<Profs> {

  @override
  Widget build(BuildContext context) {
    double totalWidth=MediaQuery.of(context).size.width;
    final an=Provider.of<Data>(context);
    return Container(
       child: an.annonces.length==0?Center(
         child: Text('Pas d\'annonces pour le moment',style: TextStyle(color: Colors.black,fontSize: 25),),
       ):ListView.builder(
        itemCount: an.annonces.length,
        itemBuilder: (ctx,index)
        {
          final x=an.annonces[index];
          return Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(width:4,color:Colors.purple),
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.withOpacity(0.5)
            ),

            width: totalWidth*0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(width: totalWidth*0.05,),
                    CircleAvatar(
                      maxRadius: 25,
                      child: Center(
                        child: Row(
                          
                          children: <Widget>[
                          
                          Text(x.day,style: TextStyle(fontSize: 26),),
                          Text('/${x.mounth}',style: TextStyle(fontSize: 16,color: Colors.grey))
                        ],),
                      ),
                    ),
                    SizedBox(width: totalWidth*0.05,),
                    Column(
                      children: <Widget>[
                        Container(
                          width: totalWidth*0.6,
                          child: FittedBox(child: Text(x.title,style: TextStyle(fontSize: 18),textAlign: TextAlign.left,))),
                Text(x.prof,style: TextStyle(fontSize: 15,color: Colors.blue),textAlign: TextAlign.left,),
                      ],
                    ),
                    SizedBox(width: totalWidth*0.1,),
                  ],
                  
                ),
                SizedBox(height: 8,),
                Container(
                  padding: EdgeInsets.all(5),
                  color: Colors.white,
                  child: Text(x.content, style: TextStyle(fontSize: 13)))
              ],
            ),
          );
        }
      ),
    );
  }
}