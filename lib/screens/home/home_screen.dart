import 'package:flutter/material.dart';
import 'package:futudem_app/screens/auth/login/login_screen.dart';
import 'package:futudem_app/screens/players_screen.dart';
import 'package:futudem_app/screens/request_screen.dart';
import 'package:futudem_app/screens/team_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:futudem_app/screens/tournament/tournament_screen.dart';

class HomeScreen extends StatefulWidget {
  final String role;
  const HomeScreen({super.key, required this.role});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<Tab> _tabs;
  late List<Widget> _tabViews;

  @override
  void initState() {
    super.initState();
    setupTabs();
  }

  void setupTabs() {
    if (widget.role == 'admin') {
      _tabs = const [
        Tab(text: 'Torneos'),
        Tab(text: 'Equipos'),
        Tab(text: 'Peticiones'),
      ];
      _tabViews = [
        TournamentScreen(role: widget.role),
        TeamScreen(),
        RequestScreen(),
      ];
    } else if (widget.role == 'capitan') {
      _tabs = const [
        Tab(text: 'Mis Jugadores'),
        Tab(text: 'Torneos'),
      ];
      _tabViews = [
        MyPlayersTab(),
        TournamentScreen(role: widget.role),
      ];
    } else {
      _tabs = const [Tab(text: 'Torneos')];
      _tabViews = [TournamentScreen(role: widget.role)];
    }
    _tabController = TabController(
      length: _tabs.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FUTUDEM - ${widget.role.toUpperCase()}',
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                final prefs =
                    await SharedPreferences.getInstance();
                await prefs.remove('userData');
                WidgetsBinding.instance
                    .addPostFrameCallback((_) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => LoginScreen(),
                        ),
                      );
                    });
              },
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabViews,
      ),
    );
  }
}
