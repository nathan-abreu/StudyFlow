import 'package:flutter/material.dart';

import '../models/book.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key, required this.book});

  final Book book;

  Widget _placeholder() => const ColoredBox(
    color: Color(0xFFDCEEFF),
    child: Center(
      child: Icon(Icons.menu_book, semanticLabel: 'Capa indisponível'),
    ),
  );

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 70,
              height: 100,
              child: book.coverUrl == null
                  ? _placeholder()
                  : Image.network(
                      book.coverUrl!,
                      fit: BoxFit.cover,
                      semanticLabel: 'Capa de ${book.title}',
                      errorBuilder: (_, error, stackTrace) => _placeholder(),
                      loadingBuilder: (_, child, progress) =>
                          progress == null ? child : _placeholder(),
                    ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(book.author),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
