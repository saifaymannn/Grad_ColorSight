import 'package:flutter/material.dart';
import 'color_detection_screen.dart';

class UploadImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ColorDetectionScreen(),
              ),
            );
          },
          child: Text('Select Image from Gallery'),
        ),
      ),
    );
  }
}
