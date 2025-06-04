import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futudem_app/screens/login/login_screen.dart';
import 'package:futudem_app/theme/app_colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://zoocbhsrtufzoogzyehe.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inpvb2NiaHNydHVmem9vZ3p5ZWhlIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0ODIwMDEyNywiZXhwIjoyMDYzNzc2MTI3fQ.eeiOnJmHLHcZoQnT1Gq2jquDej8sJ8MkUQFIbN3u41Y', // Replace with your actual Supabase URL and anon key
  );

  runApp(ProviderScope(child: FutudemApp()));
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
