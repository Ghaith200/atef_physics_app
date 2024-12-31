import 'package:atef_physics/core/utils/app_colors.dart';
import 'package:atef_physics/core/utils/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:open_filex/open_filex.dart';
import 'dart:io';
import 'dart:developer';



enum DownloadStatus { initial, downloading, downloaded, notDownloaded }

class CustomDownloadBuutton extends StatefulWidget {
  final String downloadUrl;
  final Function(String) finshedDownload;
  final String fileName, subdir;

  const CustomDownloadBuutton({
    super.key,
    required this.downloadUrl,
    required this.finshedDownload,
    required this.subdir,
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
    String p = "", path = "";
    if (Platform.isAndroid) {
      path =
          "/storage/emulated/0/Download/atef-physics/${widget.subdir}/${widget.fileName}";
      if (File(path).existsSync()) {
        p = path;
      }
    } else if (Platform.isIOS) {}
    if (p.isNotEmpty) {
      setState(() {
        _status = DownloadStatus.downloaded;
        _filePath = p;
      });
    }
  }

  void _startDownload() {
    setState(() {
      _status = DownloadStatus.downloading;
    });

    FileDownloader.downloadFile(
      url: widget.downloadUrl,
      name: widget.fileName,
      downloadDestination: DownloadDestinations.publicDownloads,
      subPath: "atef-physics/${widget.subdir}",
      onProgress: (fileName, progress) {
        log(progress.toString());
        setState(() {
          _progress = (progress / 100).clamp(0, 1);
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

  void _openFile() async {
    if (_filePath != null) {
      OpenFilex.open(_filePath!);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget buttonChild;
    switch (_status) {
      case DownloadStatus.initial:
        buttonChild = const Icon(
          Icons.download,
          size: 20,
        );
        break;
      case DownloadStatus.downloading:
        buttonChild = CircularProgressIndicator(
          value: _progress,
          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.blue),
        );
        break;
      case DownloadStatus.downloaded:
        buttonChild = const Icon(Icons.check);
        break;
      case DownloadStatus.notDownloaded:
        buttonChild = const Icon(Icons.error);
        break;
    }

    return GestureDetector(
      onTap: () {
        if (_status == DownloadStatus.downloaded) {
          _openFile();
        } else if (_status != DownloadStatus.downloading) {
          _startDownload();
        }
      },
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: buttonChild,
      ),
    );
  }
}
