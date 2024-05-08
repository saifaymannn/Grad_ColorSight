import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ColorBlindnessVideos extends StatefulWidget {
  @override
  _ColorBlindnessVideosState createState() => _ColorBlindnessVideosState();
}

class _ColorBlindnessVideosState extends State<ColorBlindnessVideos> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late YoutubePlayerController _controller1;
  late YoutubePlayerController _controller2;
  late YoutubePlayerController _controller3;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _controller1 = YoutubePlayerController(
      initialVideoId: 'Hz0gJpD8Uiw', // How to tell if you have color blindness
      flags: YoutubePlayerFlags(autoPlay: false, mute: false),
    );
    _controller2 = YoutubePlayerController(
      initialVideoId: 'cZ-QPSBTNK4', // Best treatment for color blindness
      flags: YoutubePlayerFlags(autoPlay: false, mute: false),
    );
    _controller3 = YoutubePlayerController(
      initialVideoId: '9NrmH039ffI', // Hidden Talents of the Color Blind
      flags: YoutubePlayerFlags(autoPlay: false, mute: false),
    );
  }

  Widget buildPlayer(YoutubePlayerController controller) {
    return YoutubePlayer(
      controller: controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.blueAccent,
      progressColors: ProgressBarColors(
        playedColor: Colors.blue,
        handleColor: Colors.blueAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color Blindness Videos'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Diagnosis'),
            Tab(text: 'Treatment'),
            Tab(text: 'Hidden Talents'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(child: buildPlayer(_controller1)),
          Center(child: buildPlayer(_controller2)),
          Center(child: buildPlayer(_controller3)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _tabController.dispose();
    super.dispose();
  }
}
