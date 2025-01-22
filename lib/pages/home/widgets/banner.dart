import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tuna_asis/pages/home/layouts/ai_screen.dart';

class BannerToExplore extends StatelessWidget {
  const BannerToExplore({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.tealAccent.shade700,
      ),
      child: Stack(
        children: [
          Positioned(
            top: 30,
            left: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Temukan semua yang\nkamu ingin tau",
                  style: TextStyle(
                    height: 1.1,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 33),
                      backgroundColor: Colors.white,
                      elevation: 0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return AiScreen();
                        },
                      ),
                    );
                  },
                  child: Text(
                    "Tuna Ai",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            right: -30,
            child: Image.asset(
              'assets/images/tunanetra.png',
            ),
          ),
        ],
      ),
    );
  }
}
