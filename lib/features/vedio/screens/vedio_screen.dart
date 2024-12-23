
import 'package:flutter/material.dart';
import 'package:atef_physics/features/vedio/video_widget.dart';
import 'package:atef_physics/core/models/lesson_model.dart';
import 'package:atef_physics/core/widgets/custom_appbar.dart';

class VedioScreen extends StatefulWidget {
  static const id = '/VideoScreen';
  final LessonModel lesson;
  const VedioScreen({
    super.key,
    required this.lesson,
  });

  @override
  State<VedioScreen> createState() => _VedioScreenState();
}

class _VedioScreenState extends State<VedioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBars(
        text: widget.lesson.name,
        backbutton: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Using VideoWidget to display the video
              VideoWidget(lesson: widget.lesson),
              const SizedBox(height: 10),
              // Displaying the remaining watch time
              Text(
                'Remaining Watch Time: ${widget.lesson.watchCount}',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}