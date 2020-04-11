import 'dart:math';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/moazmar_logo.dart';
import '../models/http_exception.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

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
                          'Classi !',
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
                      child: AuthCard(),
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

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
    'nom':'',
    'prenom':'',
    'cin':''
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  AnimationController _controller;
  Animation<Offset> _slideAnimation;
  Animation<double> _opacityAnimation;
    List<String>_university=[
    'Université de Tunis',
    'Université de Sousse',
    'Université de Sfax'
  ];
   List<List<String>>_fac=[
    [
      'Faculté de Médecine de Tunis'
    ],
    [
      'Faculté des Sciences Economiques et de Gestion de Sousse',
      'Institut Supérieur des Sciences Appliquées et de Technologie de Sousse',
      'Faculté de Médecine Ibn El Jazzar de Sousse',
      'Institut Supérieur de Musique de Sousse'
    ],
    [
      'Faculté de Médecine de Sfax'
    ],
  ];

  List<List<String>>_class=[
     [
      ''
    ],
    [
      'Cycle préparatoire integré A1',
      'Cycle préparatoire integré A2',
      'Formation d\'ingénieur A1',
      'Formation d\'ingénieur A2',
      'Formation d\'ingénieur A3',
    ],
    [
      ''
    ],
    [
      ''
    ]
  ];
  List<String>_type=[
    'Etudiant',
    'Professeur'
  ];
   int selectedUniversity = 0;
  int selectedFac = 0;
  int selectedClass = 0;
   int selectedType=0;
  
  



  @override
  void initState() {
    super.initState();
    _controller= AnimationController(
      vsync: this,  
      duration: Duration(milliseconds:600 ),
      );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -1.5),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
        _controller.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            title: Text('An Error Occurred!'),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
    );
  }


  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      print('invalide');
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await Provider.of<Auth>(context, listen: false).login(
          _authData['email'],
          _authData['password'],
        );
      } else {
        // Sign user up
        await Provider.of<Auth>(context, listen: false).signup(
          _authData['email'],
          _authData['password'],
          _authData['nom'],
          _authData['prenom'],
          _authData['cin'],
          _university[selectedUniversity],
          _fac[selectedUniversity][selectedFac],
          _class[selectedFac][selectedClass],
        );
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login ) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeIn,
        height: _authMode == AuthMode.Signup ? 360 : 320,
        constraints: BoxConstraints(minHeight:_authMode == AuthMode.Signup ? 360 : 320),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.only(bottom:16.0,),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                    color: _authMode==AuthMode.Login?Colors.blue: Colors.green,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                       onPressed: _authMode==AuthMode.Signup?_switchAuthMode:null, 
                       child: Container(
                        padding: EdgeInsets.symmetric(vertical:10 ),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           color: Colors.blue,
                         ),
                        width: deviceSize.width*0.25,
                        alignment: Alignment.center,
                        child: Text('Connexion ',style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),)
                        )),
                      Divider(),
                      FlatButton(onPressed:_authMode==AuthMode.Login?_switchAuthMode:null, child: Container(
                        padding: EdgeInsets.symmetric(vertical:10 ),
                        decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           color: Colors.green,
                         ),
                        width: deviceSize.width*0.25,
                        alignment: Alignment.center,
                        child: Text('Inscription',style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)))),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 2,
                    right: 20,
                    left: 20
                  ),
                  child: Column(
                    children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'E-Mail'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Invalid email!';
                      }
                    },
                    onSaved: (value) {
                      _authData['email'] = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Mot de Passe'),
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value.isEmpty || value.length < 5) {
                        return 'Password is too short!';
                      }
                    },
                    onSaved: (value) {
                      _authData['password'] = value;
                    },
                  ),
                AnimatedContainer(
                  constraints: BoxConstraints(
                    minHeight: _authMode == AuthMode.Signup ? 60 : 0,
                    maxHeight: _authMode == AuthMode.Signup ? 500 : 0,
                  ),
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeIn,
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                        enabled: _authMode == AuthMode.Signup,
                        decoration:
                            InputDecoration(labelText: 'Confirmer Le Mot de Passe'),
                        obscureText: true,
                        validator: _authMode == AuthMode.Signup
                            ? (value) {
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match!';
                                }
                              }
                            : null,
                      ),
                      DropdownButton<String>(
					              items: _university.map((String dropDownStringItem) {
					              	return DropdownMenuItem<String>(
						          	    value: dropDownStringItem,
						          	    child: Text(dropDownStringItem),
						              );
					              }).toList(),
					              onChanged: (String newValueSelected) {
						             setState(() {
						               selectedUniversity=_university.indexOf(newValueSelected);
						             });
					              },
					              value: _university[selectedUniversity],
				              ),
                      DropdownButton<String>(
					              items: _fac[selectedUniversity].map((String dropDownStringItem) {
					              	return DropdownMenuItem<String>(
						          	    value: dropDownStringItem,
						          	    child: Text(dropDownStringItem),
						              );
					              }).toList(),
					              onChanged: (String newValueSelected) {
						             setState(() {
						               selectedFac=_fac[selectedUniversity].indexOf(newValueSelected);
						             });
					              },
					              value: _fac[selectedUniversity][selectedFac],
				              ),
                      DropdownButton<String>(
					              items: _class[selectedFac].map((String dropDownStringItem) {
					              	return DropdownMenuItem<String>(
						          	    value: dropDownStringItem,
						          	    child: Text(dropDownStringItem),
						              );
					              }).toList(),
					              onChanged: (String newValueSelected) {
						             setState(() {
						               selectedClass=_class[selectedFac].indexOf(newValueSelected);
						             });
					              },
					              value: _class[selectedFac][selectedClass],
				              ),
                      DropdownButton<String>(
					              items: _type.map((String dropDownStringItem) {
					              	return DropdownMenuItem<String>(
						          	    value: dropDownStringItem,
						          	    child: Text(dropDownStringItem),
						              );
					              }).toList(),
					              onChanged: (String newValueSelected) {
						             setState(() {
						               selectedType=_type.indexOf(newValueSelected);
						             });
					              },
					              value: _type[selectedType],
				              ),
                      TextFormField(
                    decoration: InputDecoration(labelText: 'Nom'),
                    validator: _authMode == AuthMode.Signup?(value) {
                      if (value.isEmpty || value.length < 2) {
                        return 'Nom invalide';
                      }
                    }:null,
                    onSaved: (value) {
                      _authData['nom'] = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Prénom'),
                    validator:_authMode == AuthMode.Signup? (value) {
                      if (value.isEmpty || value.length < 2) {
                        return 'Prénom invalide';
                      }
                    }:null,
                    onSaved: (value) {
                      _authData['prenom'] = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Cin'),
                    keyboardType: TextInputType.number,
                    validator: _authMode == AuthMode.Signup?(value) {
                      if (value.isEmpty || value.length !=8) {
                        return 'cin invalide';
                      }
                    }:null,
                    onSaved: (value) {
                      _authData['cin'] = value;
                    },
                  ),
                        ],
                      )
                    ),
                  ),
                ),
                  
                  if (_isLoading)
                    CircularProgressIndicator()
                  else
                    RaisedButton(
                      child:
                          Text(_authMode == AuthMode.Login ? 'Connecter' : 'S\'inscrire'),
                      onPressed: _submit,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).primaryTextTheme.button.color,
                    ),
                    if(_authMode==AuthMode.Signup)
                      Container(
                        padding: EdgeInsets.symmetric(vertical:5),
                        alignment: Alignment.bottomRight,
                        child: Text(
                          '*En cliquant sur S\'inscrire, vous acceptez nos conditions.',
                          style: TextStyle(fontSize: 11),
                          ),
                      )
                  else 
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: FlatButton(
                          onPressed:(){} ,
                          child: Text("Mot de Passe oublié?"),
                          textColor: Colors.blue,
                        )
                      )
                  
                    ],
            ),
          ),
              ]),
      ),
    )
    )
    
    );
  }
}
