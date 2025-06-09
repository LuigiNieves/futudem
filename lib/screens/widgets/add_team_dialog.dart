// import 'package:flutter/material.dart';
// import 'package:futudem_app/validator/validator.dart';

// class DialogConCampos extends StatelessWidget {
//   const DialogConCampos({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () => mostrarDialogo(context),
//       child: Text('Abrir diálogo'),
//     );
//   }

//   void mostrarDialogo(BuildContext context) {
//     final TextEditingController ccController = TextEditingController();
//     final TextEditingController nombreController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Ingresar datos'),
//           content: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextField(
//                   controller: ccController,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(labelText: 'Cédula'),
//                   validator: validarCedula,
//                 ),
//                 TextField(
//                   controller: nombreController,
//                   decoration: InputDecoration(labelText: 'Nombre'),
//                   validator: validarNombre,
//                 ),
//                 TextField(
//                   controller: nombreController,
//                   decoration: InputDecoration(labelText: 'Apellido'),
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context), // Cancelar
//               child: Text('Cancelar'),
//             ),
//             TextButton(
//               onPressed: () {
//                 String cc = ccController.text;
//                 String nombre = nombreController.text;
//                 Navigator.pop(context, {'cc': cc, 'nombre': nombre});
//               },
//               child: Text('Aceptar'),
//             ),
//           ],
//         );
//       },
//     ).then((resultado) {
//       if (resultado != null) {
//         // Puedes manejar los datos aquí
//         print('CC: ${resultado['cc']}');
//         print('Nombre: ${resultado['nombre']}');
//       }
//     });
//   }
// }
