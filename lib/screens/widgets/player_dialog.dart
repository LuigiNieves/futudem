import 'package:flutter/material.dart';
import 'package:futudem_app/models/player.dart';

class PlayerDialog extends StatefulWidget {
  const PlayerDialog({super.key});

  @override
  State<PlayerDialog> createState() => _PlayerDialogState();
}

class _PlayerDialogState extends State<PlayerDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _careerController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Agregar Jugador'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Nombre'),
          ),
          TextField(
            controller: _idController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Cedula'),
          ),
          TextField(
            controller: _careerController,
            decoration: const InputDecoration(labelText: 'Carrera'),
          ),
          
        ],
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
            final age = int.tryParse(_idController.text);
            if (_nameController.text.isEmpty ||
                _idController.text.isEmpty ||
                _careerController.text.isEmpty ||
                age == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Por favor, complete todos los campos')),
              );
              return;
            }
            final newPlayer = Player(
              id: _idController.text,
              name: _nameController.text,
              career: _careerController.text,
              isApproved: false,
            );
            Navigator.of(context).pop(newPlayer); 
          },
          child: const Text('Aceptar'),
        ),
      ],
    );
  }
}
