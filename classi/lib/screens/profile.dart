import 'package:classi/providers/auth.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import 'package:flutter/material.dart';


class MyProfile extends StatefulWidget {
  static const routeName='/profile';
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

  Widget form(String text1,String text2){
    return Container(
          height: 50,
          child: Row(
            children: <Widget>[
              Container(
                width: 95,
                child: Text('  $text1',style: TextStyle(fontSize: 18,color: Colors.deepOrange),)),
                Text(' : ',style: TextStyle(fontSize: 18)),
              FittedBox(child: Container(
                width: 245,
                child: Text('$text2',style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),)))
            ],
          ),
    ) ;
  }
  @override
  Widget build(BuildContext context) {
    final pr=Provider.of<Auth>(context).etudiant;
    return Scaffold(
      appBar: AppBar(
        title: Text('Mon Profile'),
      ),
      drawer: AppDrawer(),
      body: Container(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset('assets/img/user.png',height: 250,),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width:2,color:Colors.purple.withOpacity(0.7)),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blueGrey.withOpacity(0.4)
                ),
                child: Column(
                  children: <Widget>[
                    form('Prénom',pr.prenom),
              form('Nom',pr.nom),
              form('Email',pr.email),
              form('CIN',pr.cin),
              form('Université',pr.university),
              form('Institut',pr.fac),
              form('Classe',pr.classe)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

