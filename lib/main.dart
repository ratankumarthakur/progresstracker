import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:incrementer/homepage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
      //name: "routine_tracker",                      // use // for chrome
      options: const FirebaseOptions(
          apiKey: "AIzaSyBZOgAFqCCR3hh76vvs5av2_4X86ybaA78",
          appId: "1:1002409124497:android:99ac69884928e8ea855530",
          messagingSenderId: "1002409124497",
          projectId: "tasty-home-treats"));
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
