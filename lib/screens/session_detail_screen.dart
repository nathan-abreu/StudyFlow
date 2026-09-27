import 'package:flutter/material.dart';

import '../models/study_session.dart';
import '../widgets/content_area.dart';

class SessionDetailScreen extends StatelessWidget {
  const SessionDetailScreen({super.key, required this.session});

  final StudySession session;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Detalhes da sessão')),
    body: SingleChildScrollView(
      child: ContentArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              session.subject,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              '${session.durationMinutes} minutos de estudo',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(session.formattedDate),
            const Divider(height: 40),
            Text(
              'O que foi estudado',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            SelectableText(session.description),
          ],
        ),
      ),
    ),
  );
}
