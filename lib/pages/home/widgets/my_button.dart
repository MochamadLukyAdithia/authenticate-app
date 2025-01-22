import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Color? color;
  final Color? backgroundColor;
  final IconData icon;
  final VoidCallback pressed;
  const MyButton(
      {super.key,
      required this.icon,
      required this.pressed,
      this.color,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: pressed,
      style: IconButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor:
              backgroundColor == null ? Colors.white : backgroundColor,
          fixedSize: const Size(50, 50)),
      tooltip: 'Click me',
      icon: Icon(
        icon,
        color: color == null ? Colors.black : color,
      ),
    );
  }
}
