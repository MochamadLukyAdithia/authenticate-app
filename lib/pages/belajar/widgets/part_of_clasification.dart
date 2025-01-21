import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tuna_asis/pages/home/widgets/lessons_display.dart';
import 'package:tuna_asis/pages/home/widgets/my_button.dart';

class PartOfClasification extends StatefulWidget {
  final String id;
  const PartOfClasification({super.key, required this.id});

  @override
  State<PartOfClasification> createState() => _PartOfClasificationState();
}

class _PartOfClasificationState extends State<PartOfClasification> {
  final CollectionReference categories =
      FirebaseFirestore.instance.collection('App-Category');
  Query get filteredReceipes => FirebaseFirestore.instance
      .collection('App-Receipe')
      .where('Category', isEqualTo: widget.id);
  Query get allReceipes => FirebaseFirestore.instance.collection('App-Receipe');
  Query get selectedReceipes =>
      widget.id == "All" ? allReceipes : filteredReceipes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          SizedBox(
            width: 15,
          ),
          MyButton(
            icon: Icons.arrow_back_ios_new,
            pressed: () {
              Navigator.pop(context);
            },
          ),
          Spacer(),
          Text(
            "${widget.id}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          MyButton(
            icon: Iconsax.notification,
            pressed: () {},
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 15, right: 5),
        child: Column(
          children: [
            const SizedBox(height: 10),
            StreamBuilder(
              stream: selectedReceipes.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return GridView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.78,
                    ),
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];

                      return Column(
                        children: [
                          ItemDisplay(documentSnapshot: documentSnapshot),
                          //   Row(
                          //     children: [
                          //       const Icon(
                          //         Iconsax.star1,
                          //         color: Colors.amberAccent,
                          //       ),
                          //       const SizedBox(width: 5),
                          //       Text(
                          //         documentSnapshot['Cal'],
                          //         style: const TextStyle(
                          //           fontWeight: FontWeight.bold,
                          //         ),
                          //       ),
                          //       const Text("/5"),
                          //       const SizedBox(width: 5),
                          //       Text(
                          //         "${documentSnapshot['reviews'.toString()]} Reviews",
                          //         style: const TextStyle(
                          //           color: Colors.grey,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ],
                        ],
                      );
                    },
                  );
                }
                // it means if snapshot has date then show the date otherwise show the progress bar
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
