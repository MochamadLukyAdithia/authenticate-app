import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:tuna_asis/services/open_ai.dart';
// import 'openai_service.dart';

class AiScreen extends StatefulWidget {
  const AiScreen({super.key});
  @override
  _AiScreenState createState() => _AiScreenState();
}

class _AiScreenState extends State<AiScreen> {
  // final GoogleAIService _openAIService = GoogleAIService();
  final TextEditingController _controller = TextEditingController();
  String _response = "";

  // void _getAIResponse() async {
  //   final prompt = _controller.text;
  //   final aiResponse = await _openAIService.fetchAIResponse(prompt);
  //   setState(() {
  //     _response = aiResponse;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AI Integration Example")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: "Enter your prompt"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                GenerativeModel model = GenerativeModel(
                    model: 'gemini-1.5-flash-latest', apiKey: apiKey);
                model.generateContent([Content.text(_controller.text)]).then((value) {
                  setState(() {
                    _response = value.text.toString();
                  });
                });
              },
              child: Text("Get Response"),
            ),
            SizedBox(height: 16),
            Text(
              _response,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
