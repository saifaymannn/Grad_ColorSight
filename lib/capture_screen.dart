import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';

class Capturee extends StatefulWidget {
  @override
  _CaptureeState createState() => _CaptureeState();
}

class _CaptureeState extends State<Capturee> {
  late CameraController _cameraController;
  XFile? _imageFile;
  List<Color>? _detectedColors;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    await _cameraController.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Capture Image'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (!_cameraController.value.isInitialized) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Column(
      children: [
        Expanded(
          child: _imageFile == null
              ? CameraPreview(_cameraController)
              : _detectedColors != null
              ? _buildDetectedColorsView()
              : Image.file(File(_imageFile!.path)),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                _captureImage();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              child: Text(
                'Capture Image',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _imageFile == null ? null : _retakeImage,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              child: Text(
                'Retake Image',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetectedColorsView() {
    return Column(
      children: [
        Expanded(
          child: Image.file(
            File(_imageFile!.path),
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Detected Colors:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        _detectedColors != null && _detectedColors!.isNotEmpty
            ? Column(
          children: _detectedColors!.map((color) {
            return Text(
              _colorToString(color) + ' (${_getColorName(color)})',
              style: TextStyle(
                fontSize: 16,
                color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
              ),
            );
          }).toList(),
        )
            : Text(
          'No colors detected',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Future<void> _captureImage() async {
    try {
      final XFile imageFile = await _cameraController.takePicture();
      setState(() {
        _imageFile = imageFile;
        _detectedColors = null;
      });
      _detectColors(imageFile.path);
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  void _retakeImage() {
    setState(() {
      _imageFile = null;
      _detectedColors = null;
    });
  }

  void _detectColors(String imagePath) async {
    File imageFile = File(imagePath);
    List<Color> detectedColors = await performColorDetection(imageFile);
    setState(() {
      _detectedColors = detectedColors;
    });
  }

  Future<List<Color>> performColorDetection(File imageFile) async {
    // Replace this with your actual color detection logic
    return [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.pink,
    ]; // Sample detected colors
  }

  String _colorToString(Color color) {
    return 'RGB: (${color.red}, ${color.green}, ${color.blue})';
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

    int threshold = 1000; // Set a threshold to define color similarity

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
}
