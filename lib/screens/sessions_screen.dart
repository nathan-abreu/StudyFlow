import 'package:flutter/material.dart';

import '../models/study_session.dart';
import '../widgets/content_area.dart';
import '../widgets/session_card.dart';

class SessionsScreen extends StatelessWidget {
  const SessionsScreen({
    super.key,
    required this.sessions,
    required this.onAddSession,
  });

  final List<StudySession> sessions;
  final VoidCallback onAddSession;

  @override
  Widget build(BuildContext context) => ContentArea(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Suas sessões', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 8),
        const Text('Matérias e tempos de estudo registrados.'),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: onAddSession,
          icon: const Icon(Icons.add),
          label: const Text('Nova sessão'),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: sessions.isEmpty
              ? const SingleChildScrollView(
                  child: Text(
                    'Nenhuma sessão cadastrada.',
                    textAlign: TextAlign.center,
                  ),
                )
              : ListView.builder(
                  itemCount: sessions.length,
                  itemBuilder: (_, index) =>
                      SessionCard(session: sessions[index]),
                ),
        ),
      ],
    ),
  );
}
