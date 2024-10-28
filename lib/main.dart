import 'package:chatting/firebase_options.dart';
import 'package:chatting/screens/RegisterScreen.dart';
import 'package:chatting/screens/chattingScreen.dart';
import 'package:chatting/screens/loginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        LonginScreen.id: (context) => LonginScreen(),
        ChattingScreen.id: (context) => ChattingScreen(),
      },
      debugShowCheckedModeBanner: false,
      initialRoute: LonginScreen.id,
    );
  }
}
