import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:incrementer/homepage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
      //name: "routine_tracker",                      // use // for chrome
    // tasty-home-treats
      options: const FirebaseOptions(
          apiKey: "",
          appId: "",
          messagingSenderId: "",
          projectId: ""));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Routine Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textSelectionTheme: TextSelectionThemeData(
            selectionColor: Colors.pink.shade200, // Highlight color
            selectionHandleColor: Colors.pink, // Handle (drag indicator) color
          ),
        ),
        home: homepage());
  }
}
