import 'package:flutter/material.dart';
import 'package:futudem_app/mock/data.dart';
import 'package:futudem_app/models/team.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  Widget buildGroup(String title, List<Team> teams) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: teams.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, childAspectRatio: 5),
          itemBuilder: (context, index) {
            final team = teams[index];
            return Row(
              children: [
                Image.network(team.flagUrl, width: 30),
                SizedBox(width: 10),
                Expanded(child: Text(team.name)),
                Text("PJ: 0 G:0 E:0 P:0 PTS:0"), // Puedes personalizar más adelante
              ],
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildGroup('Grupo A', groupA),
          SizedBox(height: 20),
          buildGroup('Grupo B', groupB),
        ],
      ),
    );
  }
}
