class StudySession {
  const StudySession({
    required this.subject,
    required this.durationMinutes,
    required this.description,
    required this.createdAt,
  });

  final String subject;
  final int durationMinutes;
  final String description;
  final DateTime createdAt;

  bool isOnDay(DateTime date) =>
      createdAt.year == date.year &&
      createdAt.month == date.month &&
      createdAt.day == date.day;

  String get formattedDate {
    String pad(int value) => value.toString().padLeft(2, '0');
    return '${pad(createdAt.day)}/${pad(createdAt.month)}/${createdAt.year} '
        'às ${pad(createdAt.hour)}:${pad(createdAt.minute)}';
  }
}
