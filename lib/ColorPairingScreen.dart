import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palette_generator/palette_generator.dart';
import 'utils/ColorTheoryHelper.dart';

class ColorPairingScreen extends StatefulWidget {
  @override
  _ColorPairingScreenState createState() => _ColorPairingScreenState();
}

class _ColorPairingScreenState extends State<ColorPairingScreen> {
  List<Color> pickedColors = [];
  List<File> images = [];

  Future<void> pickImage() async {
    final picker = ImagePicker();
    if (images.length >= 2) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("You can only add up to two images."),
        duration: Duration(seconds: 2),
      ));
      return;
    }
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(FileImage(imageFile));
      setState(() {
        images.add(imageFile);
        pickedColors.add(paletteGenerator.dominantColor?.color ?? Colors.black);
      });
    }
  }

  Widget buildImageColorPairs() {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 20,
        runSpacing: 20,
        children: images.asMap().entries.map((entry) {
          int idx = entry.key;
          File img = entry.value;
          Color color = pickedColors[idx];
          return Column(
            children: [
              Image.file(img, width: 100, height: 100),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: color,
                  border: Border.all(color: Colors.black),
                ),
              ),
              Text("Dominant color: ${color.toString()}"),
            ],
          );
        }).toList(),
      ),
    );
  }

  String analyzeColors() {
    if (pickedColors.length < 2) {
      return "Please add at least two colors for a meaningful comparison.";
    }
    for (int i = 0; i < pickedColors.length - 1; i++) {
      for (int j = i + 1; j < pickedColors.length; j++) {
        if (ColorTheoryHelper.areColorsComplementary(pickedColors[i], pickedColors[j])) {
          return "Found complementary colors.";
        }
      }
    }
    return "No complementary colors found.";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Color Pairing Checker"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: pickImage,
                  child: Text("Pick an Image"),
                ),
                SizedBox(height: 20),
                if (images.isNotEmpty) buildImageColorPairs(),
                SizedBox(height: 20),
                Text(analyzeColors(), style: Theme.of(context).textTheme.subtitle1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
