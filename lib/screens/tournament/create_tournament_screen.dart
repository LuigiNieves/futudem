import 'package:flutter/material.dart';

class CreateTournamentScreen extends StatefulWidget {
  const CreateTournamentScreen({super.key});

  @override
  _CreateTournamentScreenState createState() => _CreateTournamentScreenState();
}

class _CreateTournamentScreenState extends State<CreateTournamentScreen> {
  final _nombreController = TextEditingController();
  final _fechaController = TextEditingController();

  void _saveTournament() {
    final nombre = _nombreController.text;
    final fecha = _fechaController.text;

    if (nombre.isNotEmpty && fecha.isNotEmpty) {
      // Aquí deberías agregar el nuevo torneo a tu lista de torneos o manejarlo con un provider / state management.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Torneo "$nombre" creado exitosamente')),
      );
      Navigator.pop(context); // Volver a la lista
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor completa todos los campos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Torneo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Nombre del Torneo'),
            ),
            TextField(
              controller: _fechaController,
              decoration: const InputDecoration(labelText: 'Fecha de Inicio'),
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveTournament,
              child: const Text('Guardar Torneo'),
            ),
          ],
        ),
      ),
    );
  }
}
