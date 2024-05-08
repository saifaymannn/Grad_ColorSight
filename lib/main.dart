import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';  // Make sure HomePage is correctly imported
import 'color_profile_provider.dart';



void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ColorProfileProvider()),
      ],
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ColorProfileProvider>(
      builder: (context, provider, child) {
        return MaterialApp(
          home: HomePage(), // Assuming HomePage is the entry point
          builder: (context, child) {
            return ShaderMask(
              shaderCallback: (Rect bounds) {
                switch (provider.currentType) {
                  case ColorBlindnessType.protanopia:
                    return _createProtanopiaShader(bounds);
                  case ColorBlindnessType.deuteranopia:
                    return _createDeuteranopiaShader(bounds);
                  case ColorBlindnessType.tritanopia:
                    return _createTritanopiaShader(bounds);
                  default:
                    return _createNormalVisionShader(bounds);
                }
              },
              child: child!,
            );
          },
        );
      },
    );
  }

  Shader _createNormalVisionShader(Rect bounds) => LinearGradient(colors: [Colors.white, Colors.white]).createShader(bounds);
  Shader _createProtanopiaShader(Rect bounds) => LinearGradient(colors: [Colors.red, Colors.blue]).createShader(bounds); // Simplified example
  Shader _createDeuteranopiaShader(Rect bounds) => LinearGradient(colors: [Colors.green, Colors.blue]).createShader(bounds); // Simplified example
  Shader _createTritanopiaShader(Rect bounds) => LinearGradient(colors: [Colors.blue, Colors.green]).createShader(bounds); // Simplified example
}
