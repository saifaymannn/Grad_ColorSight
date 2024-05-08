import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ColorDetectionScreen extends StatefulWidget {
  @override
  _ColorDetectionScreenState createState() => _ColorDetectionScreenState();
}

class _ColorDetectionScreenState extends State<ColorDetectionScreen> {
  File? _imageFile;
  Color? _pickedColor;
  final FlutterTts flutterTts = FlutterTts();
  final GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    initializeTts();
  }

  void initializeTts() {
    flutterTts.setLanguage("en-US");
    flutterTts.setSpeechRate(0.5);
  }

  Future<void> speak(String text) async {
    if (text.isNotEmpty) {
      await flutterTts.speak(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color Detection'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            if (_imageFile != null)
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Image.file(_imageFile!, fit: BoxFit.contain),
                ),
              ),
            if (_imageFile == null)
              Expanded(
                child: Center(
                  child: Text(
                    'Tap below to select an image.',
                    style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.photo_library),
              label: Text('Select Image from Gallery'),
              onPressed: _pickImage,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.green,
                textStyle: TextStyle(fontSize: 16),
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
              ),
            ),
            if (_pickedColor != null)
              RepaintBoundary(
                key: _globalKey,
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  margin: EdgeInsets.only(top: 12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      )
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Detected Color:',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: _pickedColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        _getColorName(_pickedColor!),
                        style: TextStyle(fontSize: 24, color: _pickedColor),
                      ),
                      ElevatedButton(
                        onPressed: () => speak('The T-shirt color is ${_getColorName(_pickedColor!)}'),
                        child: Text('Announce Color'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.deepPurple,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _shareColorAndImage(),
                        child: Text('Share Color and Image'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.blue,
                        ),
                      )
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
        _updatePickedColor();
      });
    }
  }

  Future<void> _updatePickedColor() async {
    if (_imageFile == null) return;

    final PaletteGenerator paletteGenerator =
    await PaletteGenerator.fromImageProvider(FileImage(_imageFile!));

    setState(() {
      _pickedColor = paletteGenerator.dominantColor!.color;
    });
  }

  String _getColorName(Color color) {
    final Map<int, String> colorNames = {
      Colors.blue.value: 'Blue',
      Colors.pink.value: 'Red',
      Colors.yellow.value: 'Yellow',
      Colors.green.value: 'Green',
      Colors.red.value: 'Pink',
      Colors.grey.value: 'Grey',
      Colors.black.value: 'Black',
      Colors.white.value: 'White',
      Colors.brown.value: 'Brown',
      // Add more color mappings as needed
    };

    int threshold = 1000;
    int minDistance = 10000;
    int pickedColorValue = color.value;
    String pickedColorName = 'Unknown';

    colorNames.forEach((key, value) {
      int distance = ((key & 0xFF) - (pickedColorValue & 0xFF)).abs() +
          (((key >> 8) & 0xFF) - ((pickedColorValue >> 8) & 0xFF)).abs() +
          (((key >> 16) & 0xFF) - ((pickedColorValue >> 16) & 0xFF)).abs();

      if (distance < minDistance && distance < threshold) {
        minDistance = distance;
        pickedColorName = value;
      }
    });

    return pickedColorName;
  }

  Future<void> _shareColorAndImage() async {
    RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    final directory = await getApplicationDocumentsDirectory();
    File imgFile = File('${directory.path}/color.png');
    await imgFile.writeAsBytes(pngBytes);

    Share.shareFiles([_imageFile!.path, imgFile.path], text: 'Check out this color I detected along with the image!');
  }
}
