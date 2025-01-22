import 'package:google_generative_ai/google_generative_ai.dart';

const String apiKey = "AIzaSyAfCOfsZInnIEg_hthgg6Lggy55eNtfFhU";
final model = GenerativeModel(model: 'gemini-1.5-flash-latest', apiKey: apiKey);

class ModelMessage {
  final String message;
  final bool prompt;
  final DateTime time;

  ModelMessage({
    required this.message,
    required this.prompt,
    required this.time,
  });
}

