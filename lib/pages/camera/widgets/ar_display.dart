import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tuna_asis/pages/camera/widgets/detail_ar.dart';

class ArDisplay extends StatefulWidget {
  final DocumentSnapshot<Object?> documentSnapshot;

  const ArDisplay({Key? key, required this.documentSnapshot}) : super(key: key);

  @override
  State<ArDisplay> createState() => _ArDisplayState();
}

class _ArDisplayState extends State<ArDisplay> {
  @override
  Widget build(BuildContext context) {
    // Safely extract data from documentSnapshot
    final imageUrl = widget.documentSnapshot['image'] as String?;
    final text = widget.documentSnapshot['text'] as String?;

    return GestureDetector(
      onTap: () {
        // Navigate to the VirtualARViewScreen only if imageUrl is not null
        if (imageUrl != null && imageUrl.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (c) => VirtualARViewScreen(
                clickedItemImageLink: imageUrl,
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Image URL is missing.")),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Display placeholder if imageUrl is null or invalid
                Container(
                  width: double.infinity,
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: imageUrl != null && imageUrl.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(imageUrl),
                            fit: BoxFit.cover,
                          )
                        : const DecorationImage(
                            image: AssetImage('./assets/images/car.PNG'),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(height: 10),
                // Display text or a placeholder message
                Text(
                  text ?? "No title available",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
