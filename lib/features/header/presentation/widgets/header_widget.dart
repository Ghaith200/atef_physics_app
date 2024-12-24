import 'package:atef_physics/features/header/model/header_model.dart';
import 'package:atef_physics/features/header/presentation/cubit/header_cubit.dart';
import 'package:atef_physics/features/vedio/screens/vedio_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HeaderWidget extends StatelessWidget {
  final HeaderModel model;
  const HeaderWidget({super.key, required this.model});
  @override
  Widget build(BuildContext context) {
    final HeaderCubit cubit = BlocProvider.of<HeaderCubit>(context);
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: GridTile(
        header: Container(
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
        ),
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
    );
  }
}
