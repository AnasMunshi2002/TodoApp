import 'package:flutter/material.dart';
import 'package:todoapp/ToDo_App/screens/todoScreen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    exitSplash(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 160,
          foregroundImage: AssetImage('assets/splash/todo_splash.gif'),
        ),
      ),
    );
  }

  exitSplash(BuildContext context) {
    Future.delayed(Duration(seconds: 5)).then(
      (value) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ToDoScreen(),
            ));
      },
    );
  }
}
