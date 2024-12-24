import 'dart:developer';

import 'package:atef_physics/core/utils/app_colors.dart';
import 'package:atef_physics/core/utils/app_utils.dart';
import 'package:atef_physics/core/widgets/custom_button.dart';
import 'package:atef_physics/features/courses/course/screens/add_course_screen.dart';
import 'package:atef_physics/features/header/model/header_model.dart';
import 'package:atef_physics/features/header/presentation/cubit/header_cubit.dart';
import 'package:atef_physics/features/header/presentation/widgets/add_header_screen.dart';
import 'package:atef_physics/features/header/presentation/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HeaderList extends StatefulWidget {
  const HeaderList({super.key});

  @override
  State<HeaderList> createState() => _HeaderListState();
}

class _HeaderListState extends State<HeaderList> {
  List<HeaderModel> header = [];
  @override
  void initState() {
    BlocProvider.of<HeaderCubit>(context).getHeaders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HeaderCubit, HeaderState>(
      listener: (context, state) => state.mapOrNull(
        error: (value) => value.error.showError(context),
        successAll: (value) => header.addAll(value.models),
        add: (value) => header.add(value.model),
        remove: (value) =>
            header.removeWhere((test) => test.id == value.model.id),
      ),
      builder: (context, state) => state.maybeMap<Widget>(
        load: (value) => const CircularProgressIndicator(),
        orElse: () => ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: header.length + 1,
          separatorBuilder: (context, index) => const SizedBox(width: 10),
          itemBuilder: (context, index) {
            log(index.toString());
            if (index == 0) {
              return CustomButton(
                onTap: () => context.pushNamed(AddHeaderScreen.id,
                    extra: {"cubit": BlocProvider.of<HeaderCubit>(context)}),
                filled: true,
                width: AppScreenUtils.w - 50,
                boarderRadius: 20,
                child: const Icon(
                  Icons.add,
                  size: 50,
                  color: Colors.white,
                ),
              );
            }
            return SizedBox(
                width: AppScreenUtils.w - 20,
                child: HeaderWidget(model: header[index - 1]));
          },
        ),
      ),
    );
  }
}
