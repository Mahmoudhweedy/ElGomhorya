import 'package:easy_localization/easy_localization.dart';
import './constants/constants.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './models/cart.dart';
import './routes.dart';
import './services/services.dart';
import './theme.dart';
import './user/home_screen.dart';
import 'package:flutter/material.dart';
import './screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'screens/sign_choice.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: kPrimaryColor,
    ),
  );
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      startLocale: Locale('ar', 'EG'),
      path: 'assets/locales',
      supportedLocales: [
        Locale('ar', 'EG'),
        Locale('en', 'US'),
      ],
      fallbackLocale: Locale('ar', 'EG'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return AlertDialog(
            content: Text('data'),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return ChangeNotifierProvider(
            create: (context) => CartData(),
            child: MaterialApp(
            
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              locale: context.locale,
              home: LoadingScreen(),
              routes: routes,
              debugShowCheckedModeBanner: false,
              theme: theme(),
            ),
          );
        }
        return MaterialApp(
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          locale: context.locale,
          home: Scaffold(body: Center(child: LinearProgressIndicator())),
          debugShowCheckedModeBanner: false,
          theme: theme(),
        );
      },
    );
  }
}

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool lang;
  @override
  void initState() {
    Services().isLogedBefor().then((value) {
      print(value);
      if (value) {
        SharedPreferences.getInstance().then((prefs) {
          lang = prefs.containsKey("lang");
          if (prefs.containsKey("mobile") && prefs.containsKey("password")) {
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.routeName, (route) => false);
          } else if (prefs.containsKey("lang")) {
            Navigator.pushNamedAndRemoveUntil(
                context, SignChoice.routeName, (route) => false);
          }
        });
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, WelcomeScreen.routeName, (route) => false);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child:
                RefreshProgressIndicator(backgroundColor: Color(0xFFFEC40D))));
  }
}
