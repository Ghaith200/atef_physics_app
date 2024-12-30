import 'package:atef_physics/core/utils/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'dart:io';

enum DownloadStatus { initial, downloading, downloaded, notDownloaded }

class CustomDownloadBuutton extends StatefulWidget {
  final String downloadUrl;
  final Function(String) finshedDownload;
  final String fileName;

  const CustomDownloadBuutton({
    super.key,
    required this.downloadUrl,
    required this.finshedDownload,
    required this.fileName,
  });

  @override
  State<CustomDownloadBuutton> createState() => _CustomDownloadBuuttonState();
}

class _CustomDownloadBuuttonState extends State<CustomDownloadBuutton> {
  DownloadStatus _status = DownloadStatus.initial;
  double _progress = 0.0;
  String? _filePath;

  @override
  void initState() {
    super.initState();
    _checkFileExistence();
  }

  void _checkFileExistence() async {
    final path =
        "/storage/emulated/0/Download/atef-physics/${widget.fileName}.pdf";
    if (await File(path).exists()) {
      setState(() {
        _status = DownloadStatus.downloaded;
        _filePath = path;
      });
    }
  }

  void _startDownload() {
    setState(() {
      _status = DownloadStatus.downloading;
    });

    FileDownloader.downloadFile(
      url: widget.downloadUrl,
      name: "${widget.fileName}.pdf",
      downloadDestination: DownloadDestinations.publicDownloads,
      subPath: "atef-physics",
      onProgress: (fileName, progress) {
        setState(() {
          _progress = progress;
        });
      },
      onDownloadCompleted: (path) {
        setState(() {
          _status = DownloadStatus.downloaded;
          _progress = 0.0;
          _filePath = path;
        });
        widget.finshedDownload(path!);
      },
      onDownloadError: (errorMessage) {
        setState(() {
          _status = DownloadStatus.notDownloaded;
          _progress = 0.0;
        });
        AppSnackBar.showSnackBar(context, 'Download failed: $errorMessage');
      },
    );
  }

  void _openFile() {
    if (_filePath != null) {
    } else {
      AppSnackBar.showSnackBar(context, 'File not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget buttonChild;
    switch (_status) {
      case DownloadStatus.initial:
        buttonChild = const Icon(Icons.download);
        break;
      case DownloadStatus.downloading:
        buttonChild = CircularProgressIndicator(
          value: _progress,
        );
        break;
      case DownloadStatus.downloaded:
        buttonChild = const Icon(Icons.check);
        break;
      case DownloadStatus.notDownloaded:
        buttonChild = const Icon(Icons.error);
        break;
    }

    return ElevatedButton(
      onPressed: () {
        if (_status == DownloadStatus.downloaded) {
          _openFile();
        } else if (_status != DownloadStatus.downloading) {
          _startDownload();
        }
      },
      child: buttonChild,
    );
  }
}
