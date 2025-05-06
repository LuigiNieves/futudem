import 'package:flutter/material.dart';
import 'package:futudem_app/mock/data.dart';
import 'package:futudem_app/models/player.dart';  // Asegúrate de importar el modelo Player

class RequestScreen extends StatefulWidget {
  // Agregamos el parámetro key en el constructor
  const RequestScreen({super.key});

  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final Map<String, String> rejectionReasons = {};  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peticiones de Jugadores'),
      ),
      body: ListView.builder(
        itemCount: playersList.length,  
        itemBuilder: (context, index) {
          final player = playersList[index];

          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(player.name),
              subtitle: Text(player.career),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(player.isApproved == true ? 'Aprobado' : 'Pendiente'),
                  if (!player.isApproved)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.check_circle, color: Colors.green),
                          onPressed: () {
                            setState(() {
                              player.isApproved = true; 
                              rejectionReasons[player.id] = '';
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.cancel, color: Colors.red),
                          onPressed: () {
                            _showRejectionDialog(player);
                          },
                        ),
                      ],
                    ),
                  if (rejectionReasons[player.id]?.isNotEmpty ?? false)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Motivo de rechazo: ${rejectionReasons[player.id]}',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Mostrar un diálogo para ingresar el motivo de rechazo
  void _showRejectionDialog(Player player) {
    final TextEditingController reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Motivo de rechazo para ${player.name}'),
          content: TextField(
            controller: reasonController,
            decoration: InputDecoration(hintText: 'Ingrese el motivo'),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  player.isApproved = false; // Rechazar
                  rejectionReasons[player.id] = reasonController.text;
                });
                Navigator.pop(context);
              },
              child: Text('Rechazar'),
            ),
          ],
        );
      },
    );
  }
}
