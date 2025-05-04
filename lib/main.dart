import 'package:flutter/material.dart';
import 'package:futudem_app/screens/login/login_screen.dart';


void main() {
  runApp(const FotudemApp());
}

class FotudemApp extends StatelessWidget {
  const FotudemApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FOTUDEM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}

