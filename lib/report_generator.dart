// import 'dart:typed_data';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'models/question.dart';

// class ReportGenerator {
//   static Future<Uint8List> generateReport(
//       List<Question> questions, Map<int, String> userResponses) async {
//     final pdf = pw.Document();

//     // Add a title to the report
//     pdf.addPage(pw.Page(
//       build: (context) {
//         return pw.Center(
//           child: pw.Text('Quiz Report', style: pw.TextStyle(fontSize: 24)),
//         );
//       },
//     ));

//     // Add user responses to the report
//     for (var i = 0; i < questions.length; i++) {
//       final question = questions[i];
//       final userResponse = userResponses[i] ?? 'Not answered';

//       pdf.addPage(pw.Page(
//         build: (context) {
//           return pw.Column(
//             children: [
//               pw.Text('Question ${i + 1}: ${question.questionText}',
//                   style: pw.TextStyle(fontSize: 18)),
//               pw.SizedBox(height: 10),
//               pw.Text('Your Answer: $userResponse',
//                   style: pw.TextStyle(fontSize: 16)),
//               pw.SizedBox(height: 20),
//             ],
//           );
//         },
//       ));
//     }

//     // Calculate and add the quiz result to the report
//     int correctAnswers = 0;
//     userResponses.forEach((index, response) {
//       if (response == questions[index].correctAnswer) {
//         correctAnswers++;
//       }
//     });

//     pdf.addPage(pw.Page(
//       build: (context) {
//         return pw.Center(
//           child: pw.Text(
//             'Quiz Result: $correctAnswers/${questions.length} correct',
//             style: pw.TextStyle(fontSize: 20),
//           ),
//         );
//       },
//     ));

//     return pdf.save();
//   }
// }
