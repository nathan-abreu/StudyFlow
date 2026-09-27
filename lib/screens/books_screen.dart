import 'package:flutter/material.dart';

import '../models/book.dart';
import '../services/book_service.dart';
import '../widgets/book_card.dart';
import '../widgets/content_area.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  final _searchController = TextEditingController();
  final _bookService = BookService();
  List<Book> _books = [];
  bool _loading = false;
  bool _searched = false;
  String? _error;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    if (_loading || _searchController.text.trim().isEmpty) {
      return;
    }
    FocusScope.of(context).unfocus();
    setState(() {
      _loading = true;
      _error = null;
      _searched = true;
    });
    try {
      final books = await _bookService.search(_searchController.text);
      if (!mounted) return;
      setState(() => _books = books);
    } catch (_) {
      if (!mounted) return;
      setState(
        () => _error = 'Não foi possível buscar os livros. Tente novamente.',
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Widget _buildResults() {
    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(semanticsLabel: 'Buscando livros'),
      );
    }
    if (_error != null) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Text(_error!, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: _search,
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      );
    }
    if (!_searched || _books.isEmpty) {
      return SingleChildScrollView(
        child: Text(
          _searched
              ? 'Nenhum livro encontrado. Tente outro termo.'
              : 'Digite um título, autor ou assunto para pesquisar.',
          textAlign: TextAlign.center,
        ),
      );
    }
    return ListView.builder(
      itemCount: _books.length,
      itemBuilder: (_, index) => BookCard(book: _books[index]),
    );
  }

  @override
  Widget build(BuildContext context) => ContentArea(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Pesquisar livros',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        const Text('Consulta ao catálogo da Open Library.'),
        const SizedBox(height: 16),
        TextField(
          controller: _searchController,
          enabled: !_loading,
          textInputAction: TextInputAction.search,
          onSubmitted: (_) => _search(),
          decoration: const InputDecoration(
            labelText: 'Título, autor ou assunto',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        const SizedBox(height: 12),
        FilledButton.icon(
          onPressed: _loading ? null : _search,
          icon: const Icon(Icons.search),
          label: const Text('Pesquisar'),
        ),
        const SizedBox(height: 16),
        Expanded(child: _buildResults()),
      ],
    ),
  );
}
