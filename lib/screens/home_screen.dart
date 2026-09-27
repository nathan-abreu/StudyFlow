import 'package:flutter/material.dart';

import '../models/study_session.dart';
import '../models/study_user.dart';
import '../widgets/content_area.dart';
import '../widgets/session_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.user,
    required this.sessions,
    required this.today,
    required this.onAddSession,
  });

  final StudyUser user;
  final List<StudySession> sessions;
  final DateTime today;
  final VoidCallback onAddSession;
  static const dailyGoal = 120;

  @override
  Widget build(BuildContext context) {
    int todayMinutes = 0;
    int totalMinutes = 0;
    for (final session in sessions) {
      totalMinutes += session.durationMinutes;
      if (session.isOnDay(today)) {
        todayMinutes += session.durationMinutes;
      }
    }
    final progress = (todayMinutes / dailyGoal).clamp(0.0, 1.0);
    return SingleChildScrollView(
      child: ContentArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Olá, ${user.name}!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            const Text('Confira seu tempo de estudo de hoje.'),
            const SizedBox(height: 24),
            Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sua meta diária',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '$todayMinutes / $dailyGoal min',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 16),
                    LinearProgressIndicator(
                      value: progress,
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(8),
                      semanticsLabel: 'Progresso da meta diária',
                      semanticsValue: '${(progress * 100).round()}%',
                    ),
                    const SizedBox(height: 12),
                    Text(
                      todayMinutes >= dailyGoal
                          ? 'Meta diária concluída.'
                          : 'Faltam ${dailyGoal - todayMinutes} minutos para sua meta.',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 24,
              runSpacing: 12,
              children: [
                Chip(
                  avatar: const Icon(Icons.schedule),
                  label: Text('Total estudado: $totalMinutes min'),
                ),
                Chip(
                  avatar: const Icon(Icons.check_circle_outline),
                  label: Text(
                    sessions.length == 1
                        ? '1 sessão registrada'
                        : '${sessions.length} sessões registradas',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onAddSession,
              icon: const Icon(Icons.add),
              label: const Text('Nova sessão'),
            ),
            const SizedBox(height: 32),
            Text(
              'Últimas sessões',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            if (sessions.isEmpty)
              const Text('Nenhuma sessão cadastrada.')
            else
              for (final session in sessions.take(3))
                SessionCard(session: session),
          ],
        ),
      ),
    );
  }
}
