import 'package:flutter/material.dart';
import 'article_viewer_screen.dart'; // Make sure to create this file.
import 'color_blindness_video.dart'; // Import the ColorBlindnessVideos widget
import 'interactive_content.dart'; // Import the InteractiveContent widget

class LearningToolsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Responsive layout variables
    double screenPadding = MediaQuery.of(context).size.width * 0.03; // 3% of screen width
    double iconSize = MediaQuery.of(context).size.width * 0.08; // 8% of screen width
    double textSize = MediaQuery.of(context).textScaleFactor * 16; // Scale text size

    return Scaffold(
      appBar: AppBar(
        title: Text('Learning Tools'),
        backgroundColor: Colors.grey, // Customized color for the AppBar
      ),
      body: ListView(
        padding: EdgeInsets.all(screenPadding), // Use responsive padding
        children: <Widget>[
          Card(
            elevation: 4,
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                vertical: screenPadding, // Responsive vertical padding
                horizontal: screenPadding * 1.5, // Responsive horizontal padding
              ),
              leading: Icon(Icons.book, color: Colors.purple, size: iconSize), // Responsive icon size
              title: Text(
                'Understanding Color Blindness',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: textSize), // Responsive text size
              ),
              subtitle: Text(
                'Read articles about color blindness',
                style: TextStyle(fontSize: textSize * 0.9), // Slightly smaller text size for subtitles
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ArticleViewerScreen()),
                );
              },
              tileColor: Colors.purple.shade50, // Adds a background color to the list tile
            ),
          ),
          Card(
            elevation: 4,
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                vertical: screenPadding,
                horizontal: screenPadding * 1.5,
              ),
              leading: Icon(Icons.video_library, color: Colors.red, size: iconSize),
              title: Text(
                'Color Blindness Videos',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: textSize),
              ),
              subtitle: Text(
                'Watch informative videos',
                style: TextStyle(fontSize: textSize * 0.9),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ColorBlindnessVideos()),
                );
              },
              tileColor: Colors.red.shade50,
            ),
          ),
          Card(
            elevation: 4,
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                vertical: screenPadding,
                horizontal: screenPadding * 1.5,
              ),
              leading: Icon(Icons.gamepad, color: Colors.blue, size: iconSize),
              title: Text(
                'Interactive Content',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: textSize),
              ),
              subtitle: Text(
                'Engage with interactive tools',
                style: TextStyle(fontSize: textSize * 0.9),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InteractiveContent()),
                );
              },
              tileColor: Colors.blue.shade50,
            ),
          ),
        ],
      ),
    );
  }
}
