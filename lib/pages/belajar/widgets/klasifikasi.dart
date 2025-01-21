import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tuna_asis/pages/belajar/widgets/materi_detail.dart';
import 'package:tuna_asis/pages/belajar/widgets/part_of_clasification.dart';
import 'package:tuna_asis/providers/favorite_provider.dart';

class Klasifikasi extends StatelessWidget {
  final DocumentSnapshot<Object?> documentSnapshot;
  const Klasifikasi({super.key, required this.documentSnapshot});

  @override
  Widget build(BuildContext context) {
    // final provider = FavoriteProvider.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(8),
      // width: 230,
      child: Stack(children: [
        Row(
          children: [
            Container(
              width: 100,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(
                    documentSnapshot['catalog'],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  documentSnapshot['Category'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            )
          ],
        ),
        Positioned(
          top: 15,
          bottom: 15,
          right: 25,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return PartOfClasification(
                        id: documentSnapshot['Category']);
                  },
                ),
              );
            },
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.tealAccent.shade700,
              size: 30,
            ),
          ),
        ),
      ]),
    );
  }
}
