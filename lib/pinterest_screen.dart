import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';


class PinterestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Outfit Ideas', style: GoogleFonts.lato(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: PinterestFeed(),
    );
  }
}

class PinterestFeed extends StatefulWidget {
  @override
  _PinterestFeedState createState() => _PinterestFeedState();
}

class _PinterestFeedState extends State<PinterestFeed> {
  List<OutfitModel> outfits = getOutfits();
  String filter = '';

  OverlayEntry? _overlayEntry;

  @override
  Widget build(BuildContext context) {
    List<OutfitModel> filteredOutfits = outfits.where((outfit) {
      return outfit.description.toLowerCase().contains(filter.toLowerCase());
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Search',
              suffixIcon: Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onChanged: (value) {
              setState(() {
                filter = value;
              });
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredOutfits.length,
            itemBuilder: (context, index) {
              OutfitModel outfit = filteredOutfits[index];
              return GestureDetector(
                onHorizontalDragEnd: (DragEndDetails details) {
                  if (details.primaryVelocity! < 0) {
                    _showOverlay(context, "Disliked", Icons.thumb_down, Colors.red);
                  } else if (details.primaryVelocity! > 0) {
                    _showOverlay(context, "Liked", Icons.favorite, Colors.pink);
                  }
                },
                child: OutfitCard(outfit: outfit),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showOverlay(BuildContext context, String message, IconData icon, Color color) {
    _overlayEntry?.remove();
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.8,
        left: MediaQuery.of(context).size.width * 0.4,
        child: Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(50),
            ),
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: color, size: 24),
                SizedBox(width: 8),
                Text(message, style: TextStyle(color: Colors.white, fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
    );
    Overlay.of(context)!.insert(_overlayEntry!);
    Future.delayed(Duration(seconds: 2), () {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }
  static List<OutfitModel> getOutfits() {
    return [
      OutfitModel(
          imageUrl: 'assets/outfits/blackSwhitep.jpg',
          description: 'Black Sweatshirt on a White pants'),
      OutfitModel(
          imageUrl: 'assets/images/Scan12870.jpg',
          description: 'White Cargo on a White Hoodie'),
      OutfitModel(
          imageUrl: 'assets/outfits/blackSwhitep.jpg',
          description: 'Black Sweatshirt on a White pants'),
      OutfitModel(
          imageUrl: 'assets/outfits/bluePwhiteT.jpg',
          description: 'white Tee on Blue pants'),
      OutfitModel(
          imageUrl: 'assets/outfits/brownbrown.jpg',
          description: 'Brown On Brown Outfit'),
      OutfitModel(
          imageUrl: 'assets/outfits/greenHjeans.jpg',
          description: 'Green Hoodie on a blue Jeans'),
      OutfitModel(
          imageUrl: 'assets/outfits/greenSwhiteP.jpg',
          description: 'green hoodie on a white pants'),
      OutfitModel(
          imageUrl: 'assets/outfits/GreenTcreamP.jpg',
          description: 'Green tee on A creamy pants'),
      OutfitModel(
          imageUrl: 'assets/outfits/GreenTopWhite.jpg',
          description: 'Green top on a White Pants'),
      OutfitModel(
          imageUrl: 'assets/outfits/greyHblueP.jpg',
          description: 'Grey hoodie on a Blue pants'),
      OutfitModel(
          imageUrl: 'assets/outfits/GreyPblueH.jpg',
          description: 'Grey Pants on A Blue Hoodie'),
      OutfitModel(
          imageUrl: 'assets/outfits/pinkPantsgreentop.jpg',
          description: 'Green top on  Pink pants'),
      OutfitModel(
          imageUrl: 'assets/outfits/Pinktopjeans.jpg',
          description: 'Pink top on a blue Jeans'),
      OutfitModel(
          imageUrl: 'assets/outfits/redTwhiteP.jpg',
          description: 'Red Tee on a white pants'),
      OutfitModel(
          imageUrl: 'assets/outfits/whiteTblueP.jpg',
          description: 'white tee on a Blue cargo'),
      OutfitModel(
          imageUrl: 'assets/images/Scan12896.jpg',
          description: 'white hoodie on Grey Cargo Pants'),
    ];
  }
}

class OutfitModel {
  final String imageUrl;
  final String description;

  OutfitModel({required this.imageUrl, required this.description});
}

class OutfitCard extends StatelessWidget {
  final OutfitModel outfit;

  OutfitCard({required this.outfit});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15)),
            child: Image.asset(outfit.imageUrl,
                height: 400, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              outfit.description,
              style: GoogleFonts.robotoMono(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}