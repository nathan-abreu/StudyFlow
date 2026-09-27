import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_flow/main.dart';
import 'package:study_flow/screens/login_screen.dart';
import 'package:study_flow/screens/session_detail_screen.dart';

Future<void> tapText(WidgetTester tester, String text) async {
  final target = find.text(text).last;
  await tester.ensureVisible(target);
  await tester.tap(target);
  await tester.pumpAndSettle();
}

Future<void> login(WidgetTester tester) async {
  await tester.enterText(find.widgetWithText(TextFormField, 'Nome'), 'Ana');
  await tester.enterText(
    find.widgetWithText(TextFormField, 'E-mail'),
    'ana@example.com',
  );
  await tester.enterText(find.widgetWithText(TextFormField, 'Senha'), '123456');
  await tapText(tester, 'Entrar');
}

void main() {
  testWidgets('Apresentação, login, cadastro, detalhes, progresso e saída', (
    tester,
  ) async {
    await tester.pumpWidget(const StudyFlowApp());
    expect(find.text('Organize seus estudos'), findsOneWidget);
    expect(find.byType(PageView), findsOneWidget);
    await tapText(tester, 'Próximo');
    expect(find.text('Registre suas sessões'), findsOneWidget);
    await tapText(tester, 'Próximo');
    expect(find.text('Pesquise livros'), findsOneWidget);
    await tapText(tester, 'Entrar');
    await login(tester);
    expect(find.text('Olá, Ana!'), findsOneWidget);
    expect(find.text('0 / 120 min'), findsOneWidget);

    await tapText(tester, 'Nova sessão');
    await tapText(tester, 'Salvar sessão');
    expect(find.text('Informe a matéria.'), findsOneWidget);
    expect(find.text('Informe de 1 a 1440 minutos.'), findsOneWidget);
    expect(find.text('Descreva o que você estudou.'), findsOneWidget);
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Matéria'),
      'Matemática',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Duração (minutos)'),
      '0',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Descrição'),
      'Equações do segundo grau.',
    );
    await tapText(tester, 'Salvar sessão');
    expect(find.text('Informe de 1 a 1440 minutos.'), findsOneWidget);
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Duração (minutos)'),
      '60',
    );
    await tapText(tester, 'Salvar sessão');
    expect(find.text('60 / 120 min'), findsOneWidget);
    expect(
      tester
          .widget<LinearProgressIndicator>(find.byType(LinearProgressIndicator))
          .value,
      0.5,
    );

    await tapText(tester, 'Sessões');
    await tapText(tester, 'Matemática');
    expect(find.byType(SessionDetailScreen), findsOneWidget);
    expect(find.text('Equações do segundo grau.'), findsOneWidget);
    expect(find.text('60 minutos de estudo'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tapText(tester, 'Nova sessão');
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Matemática'), findsOneWidget);

    await tapText(tester, 'Perfil');
    expect(find.text('ana@example.com'), findsOneWidget);
    await tapText(tester, 'Sair');
    expect(find.byType(LoginScreen), findsOneWidget);
    await login(tester);
    expect(find.text('0 / 120 min'), findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('Login valida campos e alterna a visibilidade da senha', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
    await tapText(tester, 'Entrar');
    expect(find.text('Informe seu nome.'), findsOneWidget);
    expect(find.text('Informe um e-mail válido.'), findsOneWidget);
    expect(find.text('Use pelo menos 6 caracteres.'), findsOneWidget);
    await tester.enterText(
      find.widgetWithText(TextFormField, 'E-mail'),
      'ana@',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Senha'),
      '12345',
    );
    await tapText(tester, 'Entrar');
    expect(find.text('Informe um e-mail válido.'), findsOneWidget);
    expect(find.text('Use pelo menos 6 caracteres.'), findsOneWidget);
    expect(
      tester.widget<TextField>(find.byType(TextField).last).obscureText,
      isTrue,
    );
    await tester.tap(find.byTooltip('Mostrar senha'));
    await tester.pump();
    expect(
      tester.widget<TextField>(find.byType(TextField).last).obscureText,
      isFalse,
    );
    await tester.tap(find.byTooltip('Ocultar senha'));
    await tester.pump();
    expect(
      tester.widget<TextField>(find.byType(TextField).last).obscureText,
      isTrue,
    );
  });
}
