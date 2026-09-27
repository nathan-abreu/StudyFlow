class Book {
  const Book({required this.title, required this.author, this.coverId});

  final String title;
  final String author;
  final int? coverId;

  String? get coverUrl => coverId == null
      ? null
      : 'https://covers.openlibrary.org/b/id/$coverId-M.jpg?default=false';

  factory Book.fromJson(Map<String, dynamic> json) {
    final List<dynamic> authors = json['author_name'] ?? [];
    return Book(
      title: json['title'] as String? ?? 'Título não informado',
      author: authors.isEmpty ? 'Autor não informado' : authors.join(', '),
      coverId: json['cover_i'] as int?,
    );
  }
}
