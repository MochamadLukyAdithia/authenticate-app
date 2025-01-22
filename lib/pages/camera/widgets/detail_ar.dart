import 'package:augmented_reality_plugin/augmented_reality_plugin.dart';
import 'package:flutter/material.dart';

class VirtualARViewScreen extends StatefulWidget {
  final String? clickedItemImageLink;

  const VirtualARViewScreen({Key? key, this.clickedItemImageLink})
      : super(key: key);

  @override
  State<VirtualARViewScreen> createState() => _VirtualARViewScreenState();
}

class _VirtualARViewScreenState extends State<VirtualARViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "AR View",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: widget.clickedItemImageLink != null
          ? AugmentedRealityPlugin(widget.clickedItemImageLink!)
          : Center(
              child: Text(
                "No AR content available.",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
    );
  }
}
