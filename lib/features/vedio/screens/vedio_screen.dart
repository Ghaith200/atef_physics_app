
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseVideoPlayerPage extends StatefulWidget {
  static const id = '/video-player';
  final String fileName; // Example: "sample_video.mp4"

  const FirebaseVideoPlayerPage({Key? key, required this.fileName})
      : super(key: key);

  @override
  _FirebaseVideoPlayerPageState createState() =>
      _FirebaseVideoPlayerPageState();
}

class _FirebaseVideoPlayerPageState extends State<FirebaseVideoPlayerPage> {
  late VideoPlayerController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      // Fetch the video URL from Firebase Storage
      String videoUrl = await FirebaseStorage.instance
          .ref()
          .child('videos/${widget.fileName}')
          .getDownloadURL();

      // Initialize the video controller
      _controller = VideoPlayerController.network(videoUrl)
        ..initialize().then((_) {
          // Ensure the first frame is shown
          setState(() {
            _isLoading = false;
          });
        });
    } catch (e) {
      print("Error loading video: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Video Player"),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _controller.value.isPlaying
                              ? _controller.pause()
                              : _controller.play();
                        });
                      },
                      icon: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _controller.seekTo(Duration.zero);
                      },
                      icon: const Icon(Icons.replay),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
