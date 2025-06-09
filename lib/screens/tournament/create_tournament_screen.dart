import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futudem_app/models/tournament.dart';
import 'package:futudem_app/providers/selected_date_provider.dart';
import 'package:futudem_app/providers/tournament_team_provider.dart';
import '../widgets/date_picker_field.dart';

class CreateTournamentScreen
    extends ConsumerStatefulWidget {
  const CreateTournamentScreen({super.key});

  @override
  ConsumerState<CreateTournamentScreen> createState() =>
      _CreateTournamentScreenState();
}

class _CreateTournamentScreenState
    extends ConsumerState<CreateTournamentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _saveTournament() async {
    if (_formKey.currentState?.validate() ?? false) {
      final name = _nameController.text.trim();
      final selectedDate = ref.watch(selectedDateProvider); 
       final formattedDate = selectedDate != null
        ? '${selectedDate.day.toString().padLeft(2, '0')}/'
          '${selectedDate.month.toString().padLeft(2, '0')}/'
          '${selectedDate.year}'
        : '';

        ref.read(selectedDateProvider.notifier).state = null;


      if (selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Por favor selecciona una fecha'),
          ),
        );
        return;
      }

      try {
        final newTournament = Tournament(
          id: 0, 
          name: name,
          startDate: formattedDate,
          isActive: true,
        );
        // No es necesario asignar el id aquí, la base de datos lo generará automáticamente.
        print('torneo newTournament: $newTournament');
        await ref
            .read(tournamentControllerProvider.notifier)
            .addTournament(newTournament);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Torneo "$name" creado exitosamente',
            ),
          ),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al crear torneo: $e'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = ref.watch(selectedDateProvider);
    
    return Scaffold(
      appBar: AppBar(title: const Text('Crear Torneo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del Torneo',
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Por favor ingresa un nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const DatePickerField(),
              const SizedBox(height: 24),
             
              ElevatedButton(
                onPressed: _saveTournament,
                child: const Text('Guardar Torneo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
