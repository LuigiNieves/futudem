import 'package:flutter/material.dart';
import 'package:futudem_app/models/player.dart';
import 'package:futudem_app/models/team.dart';
import 'package:futudem_app/validator/validator.dart';

class PlayerDialog extends StatefulWidget {
  final Team team; 
  const PlayerDialog({super.key, required this.team});

  @override
  State<PlayerDialog> createState() => _PlayerDialogState();
}

class _PlayerDialogState extends State<PlayerDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController =
      TextEditingController();
  final TextEditingController _lastNameController =
      TextEditingController();
  final TextEditingController _idController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Agregar Equipo a torneo'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            
            Image.network(widget.team.shield,      
              width: 50,
              height: 50,
            ),
            const SizedBox(height: 10),
            Text(widget.team.name),
            const SizedBox(height: 10),
            Text('Registrar Capitan'
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _idController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Cedula',
              ),
              validator: validarCedula,
            ),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
              ),
              validator: validarNombre,
            ),
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: 'Apellido',
              ),
              validator: validarApellido,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Por favor, complete todos los campos',
                  ),
                ),
              );
              return;
            }
            final newPlayer = Player(
              id: int.parse(_idController.text),
              name: _nameController.text,
              lastName: _lastNameController.text,
            );

            // TODO: validar si el jugador con esa celuda ya existe

            Navigator.of(context).pop(newPlayer);
          },
          child: const Text('Aceptar'),
        ),
      ],
    );
  }
}
