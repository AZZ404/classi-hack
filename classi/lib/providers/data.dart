import 'package:flutter/material.dart';
import '../models/annonce.dart';
import '../models/seance.dart';
import '../models/travail.dart';
import '../models/event.dart';


class Data with ChangeNotifier{

  final String authToken; 
  final String userId;
  Data(this.authToken,this.userId);
  //IMPORTANT NOTICE
  //All these data must be linked with firebase but because of the limitation of the time i obliged to put it here 
  //but in normal use 
  //all that must be fetched from web server not from local data
  
List<String> _profs=[
  'Prof Cours Analyse',
  'Prof Td Analyse',
  'Prof Cours Algèbre',
  'Prof Td Algèbre',
  'Prof Cours Programmation C',
  'Prof Td Programmation C',
  'Prof Cours Algo',
  'Prof Td Algo',
  'Prof Cours E-numérique',
  'Prof Td E-numérique',
  'Prof Cours c2i',
  'Prof Td c2i',
  'Prof Français ',
  'Prof Anglais ',

];
static int openProf=0;

  List<String> get profs{
    return[..._profs];
  }


    List<Annonce> _annonces=[
      Annonce('Prof Analyse','Travail pour La séance prochaine',
      "Vous trouvez dans la rubrique d'analyse le critère d'Abel pour la convergence d'une intégrale généralisée, l'utilisation de développements asymptotiques pour étudier une intégrale généralisée, la série 7 et une liste d'exercices complémentaires.",
      "4","10"),
      Annonce(
        'Prof Algorithme',
        "Modification du Date ",
        "La date de la séance en direct a été modifié pour vous donner plus de temps à essayer de résoudre le problème envoyé",
        "4","07"

      )
    ];

  List<Annonce> get annonces{
    return [..._annonces];
  }

  List<Seance> _seances=[
    Seance(
      'Analyse',
      '12/04',
      '16h',
      'shorturl.at/dzIV1'
    ),
    Seance(
      'Algèbre',
      '14/04',
      '14h',
      'shorturl.at/hg4tT',
    ),
  ];

List<Seance> get seances{
  return [..._seances];
}

List<String> _matieres=[
  'Analyse',
  'Algébre',
  'Algorithme',
  'Programmation C',
  'C2i',
  'E-Numérique',
  'Français',
  'Anglais'
];

List<String> get matieres{
  return [..._matieres];
}
static int openMatiere=0;
static int openClub=0;

List<List<Travail>> _travails=[
  [
    Travail(
      'Serie 6',
      'Ci joint une série d\'exercices sur les intégrales impropres que vous allez la travailler et nous poser des questions lors des séances en ligne pour la correction.',
      'shorturl.at/dwJQV'
    ),
    Travail(
      'les intégrales généralisées ou impropre',
      'Vous trouvez ci-joint le chapitre sur les intégrales généralisées ou impropres. On commence par lire et comprendre les 4 premières pages.',
      'shorturl.at/stEI3'
    )
  ],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
]; 

List<Travail> get trvails{
  return [..._travails[openMatiere]];
}


List<String> _clubs=[
  'ISSATSO GOOGLE CLUB',
  'MICROSOFT ISSATSO CLUB',
  'NATEG ISSATSO STUDENT CHAPTER',
  'GENEXT CLUB',
];
List<String> get clubs{
  return [..._clubs];
}

List<List<Event>> _events=[
[
  Event(
    'Getting started with Flutter',
    "We're thrilled to announce our first online coding session : \"Getting started with Flutter \" presented by Mr Bassem Karbia a web and mobile developer and a co-organizer of GDG Sousse ",
    '8pm',
    '14/02',
    'Our Youtube Channel'
  )
],
[],
[],
[]
];

List<Event>  get events{
  return [..._events[openClub]];
}


}