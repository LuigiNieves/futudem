import 'package:flutter_riverpod/flutter_riverpod.dart';

final passwordValidatorProvider = Provider<String? Function(String?)?>((ref) {
  return (value) {
    if (value == null || value.isEmpty) {
      return 'Ingresa una contraseña';
    }

    if (value.length < 6) {
      return 'Ingresa minimo 6 caracteres';
    }

    return null;
  };
});

final emailValidatorProvider = Provider<String? Function(String?)?>((ref) {
  return (value) {
    if (value == null || value.isEmpty) {
      return 'Ingresa un correo';
    }

    final bool isAValidEmail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(value);

    if (!isAValidEmail) {
      return 'Ingrese un correo valido';
    }

    return null;
  };
});
