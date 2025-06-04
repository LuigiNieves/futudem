import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futudem_app/providers/selected_date_provider.dart';
import '../widgets/tournament_form.dart';

class DatePickerField extends ConsumerWidget {
  final String label;

  const DatePickerField({Key? key, this.label = 'Fecha de Inicio'}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final formattedDate = selectedDate != null
        ? '${selectedDate.day.toString().padLeft(2, '0')}/'
          '${selectedDate.month.toString().padLeft(2, '0')}/'
          '${selectedDate.year}'
        : '';

    return GestureDetector(
      onTap: () async {
        final now = DateTime.now();
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? now,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (picked != null) {
          ref.read(selectedDateProvider.notifier).state = picked;
        }
      },
      child: AbsorbPointer(
        child: TextFormField(
          controller:TextEditingController(
            text: formattedDate,
          ),
          decoration: InputDecoration(
            labelText: label,
            hintText: selectedDate != null
                ? TournamentFormHelper.formatDate(selectedDate)
                : 'Selecciona una fecha',
          ),
          validator: (value) {
            if (selectedDate == null) {
              return 'Por favor selecciona una fecha';
            }
            return null;
          },
        ),
      ),
    );
  }
}
