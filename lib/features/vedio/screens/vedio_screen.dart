import 'dart:developer';

import 'package:atef_physics/features/vedio/widgets/vedio_player.dart';
import 'package:atef_physics/features/vedio/widgets/vedio_web.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

class VedioScreen extends StatefulWidget {
  static const id = '/VideoScreen';
  final String lesson;
  final bool loans;
  const VedioScreen({super.key, required this.lesson, this.loans = true});

  @override
  State<VedioScreen> createState() => _VedioScreenState();
}

class _VedioScreenState extends State<VedioScreen> {
  @override
  Widget build(BuildContext context) {
    // return VedioPlayer(id: widget.lesson);
    return VedioWeb(lesson: widget.lesson, loans: widget.loans);
  }
}
