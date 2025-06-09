import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futudem_app/screens/auth/provider/auth_login_validator_provider.dart';
import 'package:futudem_app/screens/home/home_screen.dart';

class LoginnScreen extends ConsumerStatefulWidget {
  const LoginnScreen({super.key});

  @override
  ConsumerState<LoginnScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginnScreen> {
  bool _isPasswordVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final passwordValidator = ref.read(passwordValidatorProvider);
    final emailValidator = ref.read(emailValidatorProvider);

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(32.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                       Image.asset(
                    'assets/logo.png',
                    width: 250,
                    height: 250,
                  ),
                      SizedBox(height: 12.0),
                      Text(
                        'Ingresa tus credenciales para continuar',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      TextFormField(
                        controller: _emailController,
                        validator: emailValidator,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'Correo',
                          hintText: 'Ingresa tu correo',
                          prefixIcon: Icon(
                            Icons.email_outlined,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        validator: passwordValidator,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          hintText: 'Ingresa tu contraseña',
                          prefixIcon: Icon(
                            Icons.lock_outline,
                          ),
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                            icon: Icon(!_isPasswordVisible
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                             Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HomeScreen(role: 'admin')),
                              );
                            try {
                              final credential = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: _emailController.text,
                                      password: _passwordController.text);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                print('No user found for that email.');
                              } else if (e.code == 'wrong-password') {
                                print('Wrong password provided for that user.');
                              }
                            }
                          }
                        },
                        child: Text('Iniciar sesión'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
