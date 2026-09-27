import 'package:flutter/material.dart';

import '../models/study_session.dart';
import '../screens/session_detail_screen.dart';

class SessionCard extends StatelessWidget {
  const SessionCard({super.key, required this.session});

  final StudySession session;

  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: const CircleAvatar(child: Icon(Icons.auto_stories_outlined)),
      title: Text(
        session.subject,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        '${session.durationMinutes} min • ${session.formattedDate}',
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SessionDetailScreen(session: session),
        ),
      ),
    ),
  );
}
