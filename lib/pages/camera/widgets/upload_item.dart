import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tuna_asis/pages/camera/widgets/ar_display.dart';
import 'package:tuna_asis/pages/home/widgets/my_button.dart';
import 'package:tuna_asis/services/remove_bg.dart';

class UploadItem extends StatefulWidget {
  const UploadItem({super.key});

  @override
  State<UploadItem> createState() => _UploadItemState();
}

class _UploadItemState extends State<UploadItem> {
  TextEditingController sellernameController = new TextEditingController();
  TextEditingController sellerphoneController = new TextEditingController();
  TextEditingController itemnameController = new TextEditingController();
  TextEditingController itemdesctptionController = new TextEditingController();
  TextEditingController itempriceCotroller = new TextEditingController();
  Uint8List? imageFile;
  bool isUploading = false;
  final CollectionReference collectAr =
      FirebaseFirestore.instance.collection("App-Ar");

  @override
  Widget build(BuildContext context) {
    return imageFile == null ? defaultScreen() : UploadScreen(context);
  }

  captureImageWithCamera() async {
    Navigator.pop(context);
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        String imagePath = pickedImage.path;
        imageFile = await pickedImage.readAsBytes();
        imageFile = await RemoveBg().removeBackground(imagePath);
        setState(() {
          imageFile;
        });
      }
    } catch (e) {
      print("Error picking image: $e");
      imageFile = null;
      setState(() {
        imageFile;
      });
    }
  }

  chooseImageFromGallery() async {
    Navigator.pop(context);
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        String imagePath = pickedImage.path;
        imageFile = await pickedImage.readAsBytes();
        imageFile = await RemoveBg().removeBackground(imagePath);
        setState(() {
          imageFile;
        });
      }
    } catch (e) {
      print("Error picking image: $e");
      imageFile = null;
      setState(() {
        imageFile;
      });
    }
  }

  showDialogBox() {
    return showDialog(
      context: context,
      builder: (c) {
        return SimpleDialog(
          backgroundColor: Colors.black,
          title: Text(
            "Item Image",
            style: TextStyle(color: Colors.white),
          ),
          children: [
            SimpleDialogOption(
              onPressed: () {
                captureImageWithCamera();
              },
              child: Text(
                "Capture Image with camera",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                chooseImageFromGallery();
              },
              child: Text(
                "Choose Image from Galery",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget defaultScreen() {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: Text(
          "Ar screen",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: MyButton(
                icon: Icons.add_a_photo,
                pressed: () {
                  showDialogBox();
                }),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 15, right: 5),
        child: Column(
          children: [
            const SizedBox(height: 10),
            StreamBuilder(
              stream: collectAr.snapshots(),
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
                          ArDisplay(documentSnapshot: documentSnapshot),
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

  Scaffold UploadScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: Text(
          "Upload Gambar",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: MyButton(
              icon: Icons.add_a_photo,
              pressed: () {},
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          isUploading == true ? const LinearProgressIndicator() : Container(),
          SizedBox(
            height: 230,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: imageFile != null
                  ? Image.memory(imageFile!)
                  : const Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                    ),
            ),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 2,
          ),
          ListTile(
            leading: const Icon(Icons.person_pin_rounded),
            title: SizedBox(
              width: 250,
              child: TextField(
                controller: sellernameController,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    hintText: "Seller Name",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: InputBorder.none),
              ),
            ),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 2,
          ),
          ListTile(
            leading: const Icon(Icons.phone_iphone),
            title: SizedBox(
              width: 250,
              child: TextField(
                controller: sellerphoneController,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    hintText: "Seller Phone",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: InputBorder.none),
              ),
            ),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 2,
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: SizedBox(
              width: 250,
              child: TextField(
                controller: itemnameController,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    hintText: "Item Name",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: InputBorder.none),
              ),
            ),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 2,
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: SizedBox(
              width: 250,
              child: TextField(
                controller: itemdesctptionController,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    hintText: "Item Descrption",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: InputBorder.none),
              ),
            ),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 2,
          ),
          ListTile(
            leading: const Icon(Icons.price_check),
            title: SizedBox(
              width: 250,
              child: TextField(
                controller: itempriceCotroller,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    hintText: "Item Price",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: InputBorder.none),
              ),
            ),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
