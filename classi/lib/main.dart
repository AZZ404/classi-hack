import './screens/class_chat.dart';
import './screens/contact_prof.dart';
import './screens/matiere_overview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/splach.dart';
import './screens/news.dart';
import './providers/data.dart';
import './screens/emploi.dart';
import './screens/about_it.dart';
import './screens/auth_screen.dart';
import './providers/auth.dart';
import './helpers/custom_route.dart';
import './screens/matiere.dart';
import './screens/club_overview.dart';
import './screens/clubs.dart';
import './screens/profile.dart';




void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
              ChangeNotifierProxyProvider<Auth, Data>(
                create: (_) => Data('','',),
                update: (ctx, auth, previous) =>Data(
                  auth.token,auth.userId,),
                ),
        
      ],
      child: Consumer<Auth> (
        builder: (ctx,auth,child){
      ifAuth(targetScreen) => auth.isAuth ? targetScreen : AuthScreen();
        return MaterialApp(
        title: 'Mo Store',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          primaryColor: Colors.purple,
          fontFamily: 'Lato',
          pageTransitionsTheme: PageTransitionsTheme(
                  builders: {
                    TargetPlatform.android: CustomPageTransitionBuilder(),
                    TargetPlatform.iOS: CustomPageTransitionBuilder(),
                  },
                ),
        ),
        home: auth.isAuth
                  ? NewsScreen()
                  : FutureBuilder(
                      future: auth.tryAutoLogin(),
                      builder: (ctx, authResultSnapshot) =>
                          authResultSnapshot.connectionState ==
                                  ConnectionState.waiting
                              ? SplashScreen()
                              : AuthScreen(),
                    ),
        routes: {
          NewsScreen.routeName:(ctx)=>ifAuth(NewsScreen()),
          EmploiScreen.routeName:(ctx)=>EmploiScreen(),
          AboutIt.routeName:(ctx)=>ifAuth(AboutIt()),
          MatiereScreen.routeName:(ctx)=>MatiereScreen(),
          MatiereOverviewScreen.routeName:(ctx)=>MatiereOverviewScreen(),
          ClubOverviewScreen.routeName:(ctx)=>ClubOverviewScreen(),
          ClubsScreen.routeName:(ctx)=>ClubsScreen(),
          MyProfile.routeName:(ctx)=>MyProfile(),
          ClassChatApp.routeName:(ctx)=>ClassChatApp(),
          ProfScreen.routeName:(ctx)=>ProfScreen(),
          ProfOverviewScreen.routeName:(ctx)=>ProfOverviewScreen()
        },
      );
        })
    );
  }

}
