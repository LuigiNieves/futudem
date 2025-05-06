import 'package:flutter/material.dart';
import 'package:futudem_app/screens/login/login_screen.dart';
import 'package:futudem_app/theme/app_colors.dart';

void main() {
  runApp(const FutudemApp());
}

class FutudemApp extends StatelessWidget {
  const FutudemApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FUTUDEM',
      debugShowCheckedModeBanner: false,

      theme: mytheme,

      home: const LoginScreen(),
    );
  }
}
