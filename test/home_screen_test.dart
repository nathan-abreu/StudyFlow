import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_flow/models/study_session.dart';
import 'package:study_flow/models/study_user.dart';
import 'package:study_flow/screens/home_screen.dart';

void main() {
  testWidgets('Meta considera somente hoje e limita a barra a 100%', (
    tester,
  ) async {
    final today = DateTime(2026, 9, 24);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HomeScreen(
            user: const StudyUser(name: 'Ana', email: 'ana@example.com'),
            today: today,
            onAddSession: () {},
            sessions: [
              StudySession(
                subject: 'Hoje',
                durationMinutes: 150,
                description: 'Revisão',
                createdAt: today,
              ),
              StudySession(
                subject: 'Ontem',
                durationMinutes: 60,
                description: 'Exercícios',
                createdAt: today.subtract(const Duration(days: 1)),
              ),
            ],
          ),
        ),
      ),
    );
    expect(find.text('150 / 120 min'), findsOneWidget);
    expect(find.text('Total estudado: 210 min'), findsOneWidget);
    expect(
      tester
          .widget<LinearProgressIndicator>(find.byType(LinearProgressIndicator))
          .value,
      1,
    );
    expect(find.text('Meta diária concluída.'), findsOneWidget);
  });
}
