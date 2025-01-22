import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
// import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:tuna_asis/pages/home/widgets/my_button.dart';
import 'package:tuna_asis/services/open_ai.dart';

class AiScreen extends StatefulWidget {
  const AiScreen({super.key});

  @override
  State<AiScreen> createState() => _AiScreenState();
}

class _AiScreenState extends State<AiScreen> {
  TextEditingController _controller = TextEditingController();

  final List<ModelMessage> prompt = [];

  Future<void> sendMessage() async {
    final message = _controller.text;
    setState(() {
      _controller.clear();
      prompt.add(
        ModelMessage(
          message: message,
          prompt: true,
          time: DateTime.now(),
        ),
      );
    });
    final content = [Content.text(message)];
    final response = await model.generateContent(content.toList());
    // final generatedMessage = response.text;
    setState(() {
      prompt.add(
        ModelMessage(
          message: response.text ?? '',
          prompt: false,
          time: DateTime.now(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent.shade700,
      appBar: AppBar(
        backgroundColor: Colors.tealAccent.shade700,
        // automaticallyImplyLeading: false,
        title: Text(
          "Tuna Ai",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: prompt.length,
              itemBuilder: (context, index) {
                final message = prompt[index];
                return userPrompt(
                  isPrompt: message.prompt,
                  message: message.message,
                  date: DateFormat('hh:mm a').format(message.time),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(25),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                        // focusColor: Colors.black
                        // fillColor: Colors.black,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: "Masukkan pesan kamu disini"),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  child: MyButton(
                    icon: Icons.send_rounded,
                    pressed: () {
                      sendMessage();
                    },
                    backgroundColor: Colors.grey.shade200,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container userPrompt({
    required final bool isPrompt,
    required String message,
    required String date,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 15,
      ).copyWith(
        left: isPrompt ? 80 : 15,
        right: isPrompt ? 15 : 80,
      ),
      decoration: BoxDecoration(
        color: isPrompt ? Colors.teal : Colors.grey.shade300,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: isPrompt ? Radius.circular(20) : Radius.circular(0),
          bottomRight: isPrompt ? Radius.circular(0) : Radius.circular(20),
        ),
      ),
      width: double.infinity,
      padding: EdgeInsets.all(15),
      child: Column(
        // spacing: 15,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(
              fontSize: 18,
              fontWeight: isPrompt ? FontWeight.bold : FontWeight.normal,
              color: isPrompt ? Colors.white : Colors.black,
            ),
          ),
          Text(
            date,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isPrompt ? FontWeight.bold : FontWeight.normal,
              color: isPrompt ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
