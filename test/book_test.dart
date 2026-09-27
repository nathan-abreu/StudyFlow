import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:study_flow/models/book.dart';

void main() {
  test('Converte título, autores e capa do JSON em um livro', () {
    final json = jsonDecode(
      '{"title":"Matemática","author_name":["Ana","Bia"],"cover_i":123}',
    );
    final book = Book.fromJson(json);

    expect(book.title, 'Matemática');
    expect(book.author, 'Ana, Bia');
    expect(
      book.coverUrl,
      'https://covers.openlibrary.org/b/id/123-M.jpg?default=false',
    );
  });

  test('Livro sem autor ou capa usa os valores alternativos', () {
    final book = Book.fromJson({'title': 'Geografia'});

    expect(book.title, 'Geografia');
    expect(book.author, 'Autor não informado');
    expect(book.coverUrl, isNull);
  });

  test('Lista vazia de autores também usa o texto alternativo', () {
    final book = Book.fromJson({'author_name': []});

    expect(book.title, 'Título não informado');
    expect(book.author, 'Autor não informado');
  });
}
