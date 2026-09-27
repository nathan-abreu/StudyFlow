import 'dart:async';

import 'package:flutter/material.dart';

import '../models/study_session.dart';
import '../models/study_user.dart';
import 'books_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'session_form_screen.dart';
import 'sessions_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.user});

  final StudyUser user;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<StudySession> _sessions = [];
  int _selectedIndex = 0;
  late final Timer _dayTimer;
  DateTime _today = DateTime.now();

  @override
  void initState() {
    super.initState();
    _dayTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      final now = DateTime.now();
      if (now.year != _today.year ||
          now.month != _today.month ||
          now.day != _today.day) {
        setState(() => _today = now);
      }
    });
  }

  @override
  void dispose() {
    _dayTimer.cancel();
    super.dispose();
  }

  Future<void> _addSession() async {
    final session = await Navigator.push<StudySession>(
      context,
      MaterialPageRoute(builder: (_) => const SessionFormScreen()),
    );
    if (!mounted || session == null) return;
    setState(() {
      _sessions.insert(0, session);
      _today = DateTime.now();
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Sessão cadastrada!')));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('StudyFlow')),
    body: SafeArea(
      child: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeScreen(
            user: widget.user,
            sessions: _sessions,
            today: _today,
            onAddSession: _addSession,
          ),
          SessionsScreen(sessions: _sessions, onAddSession: _addSession),
          const BooksScreen(),
          ProfileScreen(user: widget.user),
        ],
      ),
    ),
    bottomNavigationBar: NavigationBar(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) => setState(() => _selectedIndex = index),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Início',
        ),
        NavigationDestination(
          icon: Icon(Icons.timer_outlined),
          selectedIcon: Icon(Icons.timer),
          label: 'Sessões',
        ),
        NavigationDestination(
          icon: Icon(Icons.menu_book_outlined),
          selectedIcon: Icon(Icons.menu_book),
          label: 'Livros',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
    ),
  );
}
