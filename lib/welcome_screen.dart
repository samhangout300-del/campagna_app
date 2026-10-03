import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _textNameController = TextEditingController();

  @override
  void dispose() {
    _textNameController.dispose();
    super.dispose();
  }

  Future<void> _saveNameAndContinue() async {
    String name = _textNameController.text.trim();
    if (name.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('username', name);

    if(!mounted) return;
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Benvenuto nella camapagna di Davide'),
              TextFormField(
                autocorrect: false,
                controller: _textNameController,
                decoration: InputDecoration(hintText: 'Scrivi il tuo nome'),
              ),
              ElevatedButton(
                onPressed: _saveNameAndContinue,
                child: Text('Continua')
              ),
            ],
          ),
        ),
      ),
    );
  }
}
