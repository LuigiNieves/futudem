import 'package:flutter/material.dart';
import 'package:futudem_app/models/relations/match_fixture_dto.dart';

class MatchDialog extends StatefulWidget {
  final MatchDto match;

  const MatchDialog({super.key, required this.match});

  @override
  State<MatchDialog> createState() => _MatchDialogState();
}

class _MatchDialogState extends State<MatchDialog> {
  final TextEditingController _homeGoalsController = TextEditingController();
  final TextEditingController _awayGoalsController = TextEditingController();
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    _homeGoalsController.text = widget.match.match.homeGoals?.toString() ?? '';
    _awayGoalsController.text = widget.match.match.awayGoals?.toString() ?? '';
    selectedDate = widget.match.match.matchDate;
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _guardarDatos() {
    final String homeText = _homeGoalsController.text.trim();
    final String awayText = _awayGoalsController.text.trim();

   

    final int? homeGoals = int.tryParse(homeText);
    final int? awayGoals = int.tryParse(awayText);

    if (homeGoals == null || awayGoals == null) {
      _mostrarError('Los goles deben ser números válidos.');
      return;
    }

    if (homeGoals < 0 || awayGoals < 0) {
      _mostrarError('Los goles no pueden ser negativos.');
      return;
    }

    final updatedMatch = MatchDto(
      match: widget.match.match.copyWith(
        homeGoals: homeGoals,
        awayGoals: awayGoals,
        matchDate: selectedDate,
      ),
      group: widget.match.group,
      homeTeam: widget.match.homeTeam,
      awayTeam: widget.match.awayTeam,
    );

    Navigator.pop(context, updatedMatch.match);
  }

  void _mostrarError(String mensaje) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(mensaje),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        '${widget.match.homeTeam.name} vs ${widget.match.awayTeam.name}',
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _homeGoalsController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Goles equipo local'),
          ),
          TextField(
            controller: _awayGoalsController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Goles equipo visitante',
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: _pickDate,
            child: Text(
              selectedDate != null
                  ? 'Fecha: ${selectedDate!.toString().split(' ')[0]}'
                  : 'Seleccionar fecha',
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(onPressed: _guardarDatos, child: const Text('Guardar')),
      ],
    );
  }
}
