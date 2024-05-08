import 'package:flutter/material.dart';
import 'home_page_body.dart';
import 'upload_image_screen.dart';
import 'pinterest_screen.dart';
import 'settings.dart';
import 'instruction_screen.dart';
import 'ColorPairingScreen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    HomePageBody(),
    PinterestScreen(),
    SettingsScreen(),
    InstructionScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,  // Ensures that the title (your logo in this case) is centered
        title: Image.asset(
          'assets/images/reree.png',  // Replace 'logapp.png' with your actual logo filename
          height: 110,  // Adjust the height according to your logo size preferences
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InstructionScreen()),
            ),
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.photo_album), label: 'Feed'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UploadImageScreen()),
        ),
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
