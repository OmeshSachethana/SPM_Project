class Question {
  final String id;
  final String questionText;
  final List<String> options;
  final String correctAnswer; // Add correctAnswer field

  Question({
    required this.id,
    required this.questionText,
    required this.options,
    required this.correctAnswer, // Add correctAnswer to the constructor
  });
}
