import 'package:atef_physics/features/offline_handler/offline_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

class OfflineBuilderWidget extends StatefulWidget {
  final Widget child;

  const OfflineBuilderWidget({
    super.key,
    required this.child,
  });

  @override
  State<OfflineBuilderWidget> createState() => _OfflineBuilderWidgetState();
}

class _OfflineBuilderWidgetState extends State<OfflineBuilderWidget> {
  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }

  // Method to check the connectivity status
  Future<void> _checkConnectivity() async {}

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (context, value, child) {
        final bool connected = !value.contains(ConnectivityResult.none);
        if (!connected) {
          return const OfflineScreen();
        } else {
          return widget.child;
        }
      },
      child: widget.child,
    );
  }
}
