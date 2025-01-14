import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback pressed;
  const MyButton({super.key, required this.icon, required this.pressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: pressed,
      style: IconButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Colors.white,
          fixedSize: const Size(50, 50)),
      tooltip: 'Click me',
      icon: Icon(icon),
    );
  }
}
