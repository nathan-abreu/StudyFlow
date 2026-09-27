import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_flow/models/book.dart';
import 'package:study_flow/screens/books_screen.dart';
import 'package:study_flow/widgets/book_card.dart';

void main() {
  testWidgets('Pesquisa vazia não inicia uma consulta', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: BooksScreen())),
    );
    expect(
      find.text('Digite um título, autor ou assunto para pesquisar.'),
      findsOneWidget,
    );
    await tester.enterText(find.byType(TextField), '   ');
    await tester.tap(find.text('Pesquisar'));
    await tester.pumpAndSettle();
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(
      find.text('Digite um título, autor ou assunto para pesquisar.'),
      findsOneWidget,
    );
  });

  testWidgets('Livro sem capa exibe título, autor e ícone', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: BookCard(
            book: Book(title: 'Álgebra', author: 'Ana'),
          ),
        ),
      ),
    );
    expect(find.text('Álgebra'), findsOneWidget);
    expect(find.text('Ana'), findsOneWidget);
    expect(find.byIcon(Icons.menu_book), findsOneWidget);
    expect(find.byType(Image), findsNothing);
  });
}
