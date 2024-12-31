import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

class VedioWeb extends StatefulWidget {
  final String lesson;
  final bool loans;
  const VedioWeb({super.key, required this.lesson, this.loans = true});

  @override
  State<VedioWeb> createState() => _VedioWebState();
}

class _VedioWebState extends State<VedioWeb> {
  late WebViewController controller;
  String videoId = "";

  @override
  void initState() {
    super.initState();
    if (widget.loans) {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    }
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      );

    // Example of how Streamable video URL might look
    if (RegExp(r'https://streamable.com/').hasMatch(widget.lesson)) {
      // Extract the video ID from Streamable URL
      videoId = widget.lesson.split('/').last;
    } else {
      videoId = widget.lesson;
    }

    // Prepare the embed code using the Streamable video URL
    final embedHtml = """
    <html>
      <body>
        <div style="position:relative; width:100%; height:0px; padding-bottom:56.250%">
          <iframe 
            allow="fullscreen" 
            allowfullscreen 
            height="100%" 
            src="https://streamable.com/e/$videoId"
            width="100%" 
            style="border:none; width:100%; height:100%; position:absolute; left:0px; top:0px; overflow:hidden;">
          </iframe>
        </div>
      </body>
    </html>
    """;
    log("final Lesson \n $embedHtml");
    // Load the HTML content into the WebView
    final uri = Uri.dataFromString(
      embedHtml,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    );

    controller.loadRequest(uri);
  }

  @override
  void dispose() {
    // Reset the screen orientation to portrait when the screen is disposed
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: WebViewWidget(
            controller: controller,
          ),
        ),
      ),
    );
  }
}
