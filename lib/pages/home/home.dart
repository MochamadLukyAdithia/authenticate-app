import 'package:flutter/material.dart';
import 'package:tuna_asis/pages/auth/signin.dart';
import 'package:tuna_asis/pages/auth/signup.dart';
import 'package:tuna_asis/pages/auth/tryslicingsignin.dart';
import 'package:tuna_asis/pages/auth/tryslicingsignup.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Color colors = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Text("Home"),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: IconButton(
              color: colors,
              icon: Icon(Icons.home),
              onPressed: () {
                setState(() {
                  colors = Colors.redAccent;
                });
              },
            ),
          ),
          Container(
            child: IconButton(
              icon: Icon(Icons.camera),
              onPressed: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
              },
            ),
          ),
          Container(
            child: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
