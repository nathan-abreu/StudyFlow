import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/book.dart';

class BookService {
  Future<List<Book>> search(String query) async {
    final uri = Uri.https('openlibrary.org', '/search.json', {
      'q': query.trim(),
      'fields': 'title,author_name,cover_i',
      'limit': '20',
      'lang': 'pt',
    });
    final response = await http.get(uri).timeout(const Duration(seconds: 20));
    if (response.statusCode != 200) {
      throw Exception('Não foi possível consultar a Open Library.');
    }
    final data =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    final books = <Book>[];
    for (final bookJson in data['docs']) {
      books.add(Book.fromJson(bookJson));
    }
    return books;
  }
}
