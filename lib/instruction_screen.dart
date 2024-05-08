import 'package:flutter/material.dart';

class InstructionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> instructions = [
      {
        "text": "Take the picture in good lighting or use the camera's flash.",
        "icon": Icons.lightbulb_outline,
      },
      {
        "text": "Capture photos in well-lit environments to ensure accurate color details.",
        "icon": Icons.wb_sunny,
      },
      {
        "text": "Place clothing items on smooth surfaces to avoid distortions.",
        "icon": Icons.layers,
      },
      {
        "text": "Use contrasting backgrounds to help distinguish clothing boundaries.",
        "icon": Icons.border_outer,
      },
      {
        "text": "Take multiple pictures from different angles for comprehensive coverage.",
        "icon": Icons.camera_alt,
      },
      {
        "text": "Clear clutter and distractions from the background.",
        "icon": Icons.cleaning_services,
      },
      {
        "text": "Avoid glare and reflections from glossy surfaces.",
        "icon": Icons.remove_red_eye,
      },
      {
        "text": "Zoom in to capture finer details, especially for patterns.",
        "icon": Icons.zoom_in,
      },
      {
        "text": "Keep the camera stable to minimize shake and ensure focus.",
        "icon": Icons.image_aspect_ratio,
      },
      {
        "text": "Clean the camera lens to avoid smudges affecting clarity.",
        "icon": Icons.blur_circular,
      },
      {
        "text": "Maintain consistency in background color and lighting conditions.",
        "icon": Icons.palette,
      },
      {
        "text": "Optionally, include a color reference object for calibration.",
        "icon": Icons.color_lens,
      },
      {
        "text": "Review photos before uploading to ensure compliance with guidelines.",
        "icon": Icons.check_circle,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Instruction Manual'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: instructions.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(instructions[index]['icon'], color: Colors.blue),
              title: Text(
                instructions[index]['text'],
                style: TextStyle(fontSize: 16),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            ),
          );
        },
      ),
    );
  }
}
