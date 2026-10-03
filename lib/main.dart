import 'package:flutter/material.dart';

import 'dart:developer' as developer;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'welcome_screen.dart';
import 'home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> recuperaTokenFCM() async {
  try {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    await messaging.requestPermission();
    if (token != null) {
      developer.log("Token di registrazione FCM: $token", name: "FCM_TEST");
    } else {
      developer.log("Token ricevuto nullo", name: "FCM_TEST");
    }
  } catch (e, stackTrace) {
    developer.log(
      "Recupero del token FCM non riuscito",
      name: "FCM_TEST",
      error: e,
      stackTrace: stackTrace,
    );
  }
}

void main() async {
  // Assicura che i binding di Flutter siano pronti prima dei servizi nativi
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Inizializza Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // 2. Chiama la funzione per recuperare il token
  await recuperaTokenFCM();

  final prefs = await SharedPreferences.getInstance();
  final username = prefs.getString('username');

  runApp(CampagnaApp(username: username));
}

class CampagnaApp extends StatelessWidget {
  const CampagnaApp({super.key, required this.username});

  final String? username;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campagna App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        fontFamily: GoogleFonts.robotoSlab().fontFamily,
      ),
      home: username != null ? const HomeScreen() : const WelcomeScreen(),
    );
  }
}