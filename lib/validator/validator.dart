// validators.dart

String? validarCedula(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Ingrese la cédula';
  }
  if (int.tryParse(value) == null) {
    return 'Debe ser un número válido';
  }
  return null;
}

String? validarNombre(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Ingrese el nombre';
  }
  return null;
}

String? validarApellido(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Ingrese el apellido';
  }
  return null;
}
