import 'package:flutter/material.dart';
import 'package:futudem_app/screens/request_screen.dart';
import 'package:futudem_app/screens/team_screen.dart';
import 'package:futudem_app/screens/tournament/tournament_screen.dart';


class HomeScreen extends StatefulWidget {
  final String role;
  const HomeScreen({super.key, required this.role});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
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
        Tab(text: 'Mis Equipos'),
        Tab(text: 'Torneos'),
      ];
      _tabViews =  [
        TeamScreen(), 
        TournamentScreen(role: widget.role),
      ];
    } else {
      _tabs = const [
        Tab(text: 'Torneos'),
      ];
      _tabViews =  [
        TournamentScreen(role: widget.role),
      ];
    }
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FOTUDEM - ${widget.role.toUpperCase()}'),
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
