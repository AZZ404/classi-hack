import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/http_exception.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../models/etudiant.dart';



class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }
  
  void logout () async{
  _token=null;
  _expiryDate=null;
  _userId=null;
  if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
      final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();

  notifyListeners();
  }
  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    print("starting");
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }


  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/$urlSegment?key=AIzaSyC-sxsA8D8gsdaABDVZ9oBpJkv8rhz4vLY';
 try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      print('conexion en cours');
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);}
        _token = responseData['idToken'];
        _userId = responseData['localId'];
       _expiryDate = DateTime.now().add(
          Duration(
            seconds: int.parse(
             responseData['expiresIn'],
          ),
        ),);
        _autoLogout();
        notifyListeners();
              final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'expiryDate': _expiryDate.toIso8601String(),
        },
      );
      prefs.setString('userData', userData);
      
    } catch (error) {
      throw error;
    }
  }
  Future<void> _inscrire(
      String email, String password,String nom, String prenom,String cin,
      String university,String fac,String classe,       String urlSegment) async {
    final url =
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/$urlSegment?key=AIzaSyC-sxsA8D8gsdaABDVZ9oBpJkv8rhz4vLY';
 try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);}
        _token = responseData['idToken'];
        _userId = responseData['localId'];
       _expiryDate = DateTime.now().add(
          Duration(
            seconds: int.parse(
             responseData['expiresIn'],
          ),
        ),);
        _autoLogout();
        notifyListeners();
              final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'expiryDate': _expiryDate.toIso8601String(),
        },
      );
              addData(email, nom, prenom, cin, university, fac, classe, userId, _token);

      prefs.setString('userData', userData);
      
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password,String nom, String prenom, String cin,String university,String fac,String classe,) async {
    return _inscrire(email, password,nom,prenom,cin,university,fac,classe,     'signupNewUser');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'verifyPassword');
  }



  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData = json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }


    Future<void> addData(
      String email,String nom,String prenom,String cin ,String university,String fac,String classe,
      String userId,String authToken
      ) async {
    final url='https://classi-3cc8d.firebaseio.com/profiles/$userId.json?auth=$authToken';
    final timeStamp=DateTime.now();
    final response=await http.post(url,
    body:json.encode({
            'email':email,
            'prenom':prenom,
            'nom':nom,
            'cin':cin,
            'university':university,
            'fac':fac,
            'classe':classe,
            'createdDate':timeStamp.toString()
    }));

    print('heyhey $response');
    notifyListeners();
  }

  Etudiant _etudiant ;

Etudiant get etudiant{
  return _etudiant;
}
   Future<void> fetchAndSetData() async {
    final url = 'https://classi-3cc8d.firebaseio.com/profiles/$userId.json?auth=$_token';
    final response = await http.get(url);
    
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((profilId, profilData) {
      _etudiant=Etudiant(
        nom: profilData['nom'],
        prenom: profilData['prenom'],
        cin: profilData['cin'],
        university: profilData['university'],
        fac: profilData['fac'],
        classe: profilData['classe'],
        email: profilData['email']
      );
      
    });
    notifyListeners();
  }

  
}
