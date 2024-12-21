import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:firebase_storage/firebase_storage.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String fileName;

  const VideoPlayerScreen({required this.fileName});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  String? _videoUrl;
  late BetterPlayerController _controller;

  @override
  void initState() {
    super.initState();
    fetchVideoUrl();
  }

  Future<void> fetchVideoUrl() async {
    try {
      final url = await FirebaseStorage.instance
          .ref()
          .child('videos/${widget.fileName}')
          .getDownloadURL();
      setState(() {
        _videoUrl = url;
        _controller = BetterPlayerController(
          BetterPlayerConfiguration(),
          betterPlayerDataSource: BetterPlayerDataSource(
            BetterPlayerDataSourceType.network,
            _videoUrl!,
          ),
        );
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firebase Video Player')),
      body: _videoUrl == null
          ? Center(child: CircularProgressIndicator())
          : BetterPlayer(controller: _controller),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
