import 'package:flutter/material.dart';
import 'package:futudem_app/mock/data.dart';
import 'package:futudem_app/screens/home/home_screen.dart';
import 'package:futudem_app/theme/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // Función para verificar las credenciales
  void _login() {
    final username = _usernameController.text;
    final password = _passwordController.text;

    // Buscar si el usuario y la contraseña coinciden en la lista de usuarios
    final usuario = usuariosRegistrados.firstWhere(
      (user) => user['user'] == username && user['pass'] == password,
      orElse: () => {},
    );

    if (usuario.isNotEmpty) {
      // Si el usuario existe y las credenciales son correctas
      final role = usuario['rol'] ?? '';
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(role: role)),
      );
    } else {
      // Mostrar mensaje de error si las credenciales no son correctas
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuario o contraseña incorrectos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text(
          'FOTUDEM - Login',
          style: TextStyle(color: AppColors.button),
        ),
      ),
      backgroundColor: AppColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _usernameController,
                style: TextStyle(color: AppColors.inputText),
                obscureText: true,
                cursorColor: AppColors.inputText,

                decoration: const InputDecoration(
                  labelText: 'Nombre de usuario',
                  labelStyle: TextStyle(color: AppColors.labelText),
                  focusedBorder: OutlineInputBorder(
                    // Color de la barra cuando está enfocado
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  labelStyle: TextStyle(color: AppColors.labelText),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.button,
                ),
                child: const Text('Iniciar sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
