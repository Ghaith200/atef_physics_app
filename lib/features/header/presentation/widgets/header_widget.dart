import 'package:atef_physics/core/utils/app_utils.dart';
import 'package:atef_physics/core/utils/storage.dart';
import 'package:atef_physics/features/header/model/header_model.dart';
import 'package:atef_physics/features/header/presentation/cubit/header_cubit.dart';
import 'package:atef_physics/features/vedio/screens/vedio_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeaderWidget extends StatelessWidget {
  final HeaderModel model;
  const HeaderWidget({super.key, required this.model});
  @override
  Widget build(BuildContext context) {
    final HeaderCubit cubit = BlocProvider.of<HeaderCubit>(context);
    return Container(
      width: AppScreenUtils.w - 50,
      margin: const EdgeInsets.all(10),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () => model.isVideo
            ? null
            : showImageFullScreen(context, model.videoPath),
        child: GridTile(
          header: Storage.instance.isAdmin
              ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 15, vertical: 10),
                  alignment: Alignment.topRight,
                  clipBehavior: Clip.hardEdge,
                  child: GestureDetector(
                    onTap: () => cubit.removeHeader(model: model),
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(.6),
                      child: const Icon(Icons.delete),
                    ),
                  ),
                )
              : null,
          child: model.isVideo
              ? VedioScreen(
                  lesson: model.videoPath,
                  loans: false,
                )
              : CachedNetworkImage(
                  imageUrl: model.videoPath,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }

  void showImageFullScreen(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => GestureDetector(
        onTap: () => Navigator.of(context).pop(), // Close the dialog on tap
        child: Container(
          color: Colors.white
              .withOpacity(.1), // Background color for the full-screen view
          child: Center(
            child: InteractiveViewer(
              panEnabled: true, // Enable panning
              scaleEnabled: true, // Enable scaling
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
