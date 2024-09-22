import 'package:flutter/material.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';
import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget {
  const VideoApp({super.key});

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
        Uri.parse('https://apivideo-demo.s3.amazonaws.com/hello.mp4'))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          backgroundColor: PrimaryColor.primary600,
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            color: Colors.white,
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
