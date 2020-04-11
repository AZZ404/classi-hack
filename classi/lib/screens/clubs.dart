import './club_overview.dart';
import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../providers/data.dart';


class ClubsScreen extends StatelessWidget {
  static const routeName='/clubs';
  @override
  Widget build(BuildContext context) {
    final cl=Provider.of<Data>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Clubs'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: cl.clubs.length,
        itemBuilder: (ctx,index){
          final x=cl.clubs[index];
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
              Data.openClub=index;
              Navigator.of(context).pushNamed(ClubOverviewScreen.routeName);
            },
          );
        },
      ),
    );
  }
}