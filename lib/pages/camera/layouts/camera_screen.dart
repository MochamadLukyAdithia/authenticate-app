import 'package:flutter/material.dart';
import 'package:tuna_asis/pages/camera/widgets/upload_item.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    return UploadItem(
    );
  }
}
