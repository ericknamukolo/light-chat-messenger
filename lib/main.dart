import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lightning_messenger/screens/entry_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    FlashChat(),
  );
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black54),
        ),
      ),
      home: EntryScreen(),
    );
  }
}
