import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../providers/data.dart';


class ProfScreen extends StatelessWidget {
  static const routeName='/profs';
  @override
  Widget build(BuildContext context) {
    final pr=Provider.of<Data>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacter un Prof'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: pr.profs.length,
        itemBuilder: (ctx,index){
          final x=pr.profs[index];
          return GestureDetector(
            child: Container(
              height: 80,
              margin: EdgeInsets.symmetric(horizontal:15,vertical: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(width:1,color:Colors.blue),
                borderRadius: BorderRadius.circular(15)
              ),
              child: Text(x,textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blue,fontSize: 25,fontWeight: FontWeight.bold,decoration: TextDecoration.underline)),
            ),
            onTap: (){
              Data.openProf=index;
              Navigator.of(context).pushNamed(ProfOverviewScreen.routeName);
            },
          );
        },
      ),
    );
  }
}




class ProfOverviewScreen extends StatelessWidget {
  static const routeName='/prof_overview';

  @override
  Widget build(BuildContext context) {
        final pr=Provider.of<Data>(context);
    return Scaffold(
      appBar: AppBar(title: Text(pr.profs[Data.openProf]),),
      body: Center(
      child: Text('En construction',style: TextStyle(fontSize: 22),textAlign: TextAlign.center,),
    )
    );
  }
}