import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tuna_asis/pages/belajar/widgets/materi_detail.dart';
import 'package:tuna_asis/providers/favorite_provider.dart';

class ItemDisplay extends StatelessWidget {
  final DocumentSnapshot<Object?> documentSnapshot;
  const ItemDisplay({super.key, required this.documentSnapshot});

  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                MateriDetail(documentSnapshot: documentSnapshot),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 10),
        width: 230,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: documentSnapshot['image'],
                  child: Container(
                    width: double.infinity,
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: NetworkImage(
                            documentSnapshot['image'],
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${documentSnapshot['name']}",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Iconsax.flash_1,
                      size: 16,
                      color: Colors.grey,
                    ),
                    Text(
                      "${documentSnapshot['Cal']} Lesson",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Iconsax.clock,
                      size: 16,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${documentSnapshot['time']}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
                top: 5,
                right: 5,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white,
                  child: InkWell(
                    onTap: () {
                      provider.togglerFavorite(documentSnapshot);
                    },
                    child: Icon(
                      provider.isExist(documentSnapshot)
                          ? Iconsax.heart5
                          : Iconsax.heart,
                      size: 20,
                      color: provider.isExist(documentSnapshot)
                          ? Colors.red
                          : Colors.black,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
