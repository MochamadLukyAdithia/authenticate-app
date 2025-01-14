import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tuna_asis/pages/home/widgets/banner.dart';
import 'package:tuna_asis/pages/home/widgets/features_display.dart';
import 'package:tuna_asis/pages/home/widgets/my_button.dart';
import 'package:tuna_asis/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    headerPath(),
                    searchPath(),
                    const BannerToExplore(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "Categories",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    selectedCategory(),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Cepat dan Mudah",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.1,
                            fontSize: 20,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Lihat Semua",
                            style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              StreamBuilder(
                stream: selectedReceipes.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    final List<DocumentSnapshot> recipes =
                        snapshot.data?.docs ?? [];
                    return Padding(
                      padding: EdgeInsets.only(top: 5, left: 15),
                      child: SingleChildScrollView(
                        child: Row(
                            children: recipes.map(
                          (e) {
                            return ItemDisplay(documentSnapshot: e);
                          },
                        ).toList()),
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
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> selectedCategory() {
    return StreamBuilder(
      stream: categories.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasData) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                streamSnapshot.data!.docs.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      category = streamSnapshot.data!.docs[index]["name"];
                    });
                    // navigate to new screen
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color:
                            category == streamSnapshot.data!.docs[index]["name"]
                                ? Colors.teal
                                : Colors.white),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    margin: EdgeInsets.only(right: 20),
                    child: Text(
                      streamSnapshot.data!.docs[index]["name"],
                      style: TextStyle(
                          color: category ==
                                  streamSnapshot.data!.docs[index]["name"]
                              ? Colors.white
                              : Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Padding searchPath() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 22),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Cari...",
          hintStyle: TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          prefixIcon: Icon(Iconsax.search_normal),
        ),
        onChanged: (value) {
          // Handle search query
        },
        onSubmitted: (value) {
          // Handle search query submission
        },
      ),
    );
  }

  Row headerPath() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: const Text(
            "Ada yang bisa kami\nbantu Tania?",
            style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 32, height: 1),
          ),
        ),
        const Spacer(),
        MyButton(icon: Iconsax.notification, pressed: () {})
      ],
    );
  }
}
