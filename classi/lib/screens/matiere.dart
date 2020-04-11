import './matiere_overview.dart';
import 'package:classi/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/data.dart';

class MatiereScreen extends StatefulWidget {
  static final routeName='/matieres';


  @override
  _MatiereScreenState createState() => _MatiereScreenState();
}

class _MatiereScreenState extends State<MatiereScreen> {
  @override
  Widget build(BuildContext context) {
    final ma=Provider.of<Data>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Matieres'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: ma.matieres.length,
        itemBuilder: (ctx,index){
          final x=ma.matieres[index];
          return GestureDetector(
            child: Container(
              height: 80,
              margin: EdgeInsets.symmetric(horizontal:15,vertical: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(width:1,color:Colors.blue),
                borderRadius: BorderRadius.circular(15)
              ),
              child: Text(x,style: TextStyle(color: Colors.blue,fontSize: 25,fontWeight: FontWeight.bold,decoration: TextDecoration.underline)),
            ),
            onTap: (){
              Data.openMatiere=index;
              Navigator.of(context).pushNamed(MatiereOverviewScreen.routeName);
            },
          );
        },
      ),
    );
  }
}