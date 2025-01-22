import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tuna_asis/pages/belajar/widgets/klasifikasi.dart';
import 'package:tuna_asis/pages/home/widgets/lessons_display.dart';
import 'package:tuna_asis/pages/home/widgets/my_button.dart';
import 'package:tuna_asis/providers/favorite_provider.dart';

class BelajarScreen extends StatefulWidget {
  const BelajarScreen({super.key});

  @override
  State<BelajarScreen> createState() => _BelajarScreenState();
}

class _BelajarScreenState extends State<BelajarScreen> {
  String category = 'All';
  // For category
  final CollectionReference categories =
      FirebaseFirestore.instance.collection('App-Category');
  // For item display
  Query get filteredReceipes => FirebaseFirestore.instance
      .collection('App-Receipe')
      .where('Category', isEqualTo: category);
  Query get allReceipes => FirebaseFirestore.instance.collection('App-Receipe');
  Query get selectedReceipes =>
      category == "All" ? allReceipes : filteredReceipes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade200,
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: [
            SizedBox(
              width: 50,
            ),
            Spacer(),
            Text(
              "Tunarungu Belajar",
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
        body: Padding(
          padding: EdgeInsets.only(top: 25),
          child: Column(
            children: [
              StreamBuilder(
                stream: selectedReceipes.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    final List<DocumentSnapshot> recipes =
                        snapshot.data?.docs ?? [];
                    return Padding(
                      padding: EdgeInsets.only(top: 5, left: 15, bottom: 5),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          spacing: 15,
                          children: recipes.map(
                            (e) {
                              return Klasifikasi(documentSnapshot: e);
                            },
                          ).toList(),
                        ),
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ));
  }

  // Stack ShowCatalog(DocumentSnapshot<Object?> Item, FavoriteProvider provider) {
  //   return Stack(
  //     children: [
  //       Padding(
  //         padding: EdgeInsets.all(15),
  //         child: Container(
  //           padding: EdgeInsets.all(10),
  //           width: double.infinity,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(20),
  //             color: Colors.grey.shade200,
  //           ),
  //           child: Row(
  //             children: [
  //               Container(
  //                 width: 100,
  //                 height: 80,
  //                 decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.circular(20),
  //                   image: DecorationImage(
  //                     fit: BoxFit.cover,
  //                     image: NetworkImage(
  //                       Item['image'],
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(
  //                 width: 10,
  //               ),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     Item['name'],
  //                     style:
  //                         TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
  //                   ),
  //                   SizedBox(
  //                     height: 5,
  //                   ),
  //                   Row(
  //                     children: [
  //                       Icon(
  //                         Iconsax.flash_1,
  //                         size: 16,
  //                         color: Colors.grey,
  //                       ),
  //                       Text(
  //                         "${Item['Cal']} Lesson",
  //                         style: TextStyle(
  //                           fontSize: 14,
  //                           fontWeight: FontWeight.bold,
  //                           color: Colors.grey,
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         width: 10,
  //                       ),
  //                       Icon(
  //                         Iconsax.clock,
  //                         size: 16,
  //                         color: Colors.grey,
  //                       ),
  //                       SizedBox(
  //                         width: 10,
  //                       ),
  //                       Text(
  //                         "${Item['time']}",
  //                         style: TextStyle(
  //                           fontSize: 14,
  //                           fontWeight: FontWeight.bold,
  //                           color: Colors.grey,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //       Positioned(
  //         top: 15,
  //         bottom: 15,
  //         right: 40,
  //         child: GestureDetector(
  //           onTap: () {
  //             setState(() {
  //               provider.togglerFavorite(Item);
  //             });
  //           },
  //           child: Icon(
  //             Icons.arrow_forward_ios,
  //             color: Colors.tealAccent.shade700,
  //             size: 30,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
