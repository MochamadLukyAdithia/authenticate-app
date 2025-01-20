import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tuna_asis/pages/home/widgets/my_button.dart';
import 'package:tuna_asis/providers/favorite_provider.dart';

class MateriDetail extends StatefulWidget {
  final DocumentSnapshot<Object?> documentSnapshot;
  const MateriDetail({super.key, required this.documentSnapshot});

  @override
  State<MateriDetail> createState() => _MateriDetailState();
}

class _MateriDetailState extends State<MateriDetail> {
  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    return Scaffold(
      // appBar: AppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MulaiBelajar(provider),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: widget.documentSnapshot['image'],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      // color: Colors.amber,
                      // padding: EdgeInsets.symmetric(horizontal: 50),
                      height: MediaQuery.of(context).size.height / 2,
                      decoration: BoxDecoration(
                        // color: Colors.amber,
                        // borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: NetworkImage(
                            widget.documentSnapshot['image'],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 40,
                    left: 10,
                    right: 10,
                    child: Row(
                      children: [
                        MyButton(
                          icon: Icons.arrow_back_ios_new,
                          pressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Spacer(),
                        MyButton(icon: Iconsax.notification, pressed: () {})
                      ],
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  FloatingActionButton MulaiBelajar(FavoriteProvider provider) {
    return FloatingActionButton.extended(
      backgroundColor: Colors.transparent,
      elevation: 0,
      onPressed: () {},
      label: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Row(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.tealAccent.shade700,
                  padding: EdgeInsets.symmetric(
                    horizontal: 100,
                    vertical: 10,
                  ),
                  foregroundColor: Colors.white),
              onPressed: () {},
              child: Text(
                "Mulai belajar",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
              style: IconButton.styleFrom(
                shape: CircleBorder(
                  side: BorderSide(
                    color: Colors.grey.shade400,
                    width: 2,
                  ),
                ),
              ),
              onPressed: () {
                provider.togglerFavorite(widget.documentSnapshot);
              },
              icon: Icon(
                provider.isExist(widget.documentSnapshot)
                    ? Iconsax.heart5
                    : Iconsax.heart,
                color: provider.isExist(widget.documentSnapshot)
                    ? Colors.red
                    : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
