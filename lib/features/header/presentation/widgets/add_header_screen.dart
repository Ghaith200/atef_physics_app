import 'package:atef_physics/core/utils/app_snack_bar.dart';
import 'package:atef_physics/core/utils/validator_utils.dart';
import 'package:atef_physics/core/widgets/custom_appbar.dart';
import 'package:atef_physics/core/widgets/custom_button.dart';
import 'package:atef_physics/core/widgets/custom_image_picker.dart';
import 'package:atef_physics/features/header/presentation/cubit/header_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddHeaderScreen extends StatefulWidget {
  const AddHeaderScreen({super.key});
  static const String id = "/AddHeaderScreen";

  @override
  State<AddHeaderScreen> createState() => _AddHeaderScreenState();
}

class _AddHeaderScreenState extends State<AddHeaderScreen>
    with TickerProviderStateMixin {
  String? path;
  late TextEditingController titleController;
  late TabController pageController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    titleController = TextEditingController();
    pageController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBars(
        text: "Add Announcment",
        backbutton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(
          children: [
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TabBar(
                      controller: pageController,
                      tabs: [
                        Tab(text: "Photo"),
                        Tab(text: "Video"),
                      ],
                    ),
                    Expanded(
                      // height: AppScreenUtils.h,
                      child: TabBarView(
                        controller: pageController,
                        children: [
                          // Tab for Added Users
                          Center(
                            child: CustomImagePicker(
                              ontap: (p0) => path = p0.path,
                              boxDecoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.add_a_photo),
                            ),
                          ),
                          // Tab for Enrolled Users
                          Center(
                            child: Form(
                              key: formKey,
                              child: TextFormField(
                                controller: titleController,
                                decoration: const InputDecoration(
                                  labelText: 'Video Link',
                                ),
                                validator: (value) =>
                                    Validators.videoLink(value),
                              ),
                            ),
                          )
                          // Tab for Not Found Users
                        ],
                      ),
                    ),
                    CustomButton(
                      onTap: () async {
                        final HeaderCubit cubit =
                            BlocProvider.of<HeaderCubit>(context);
                        if (pageController.index == 0) {
                          if (path == null) {
                            AppSnackBar.showSnackBar(
                                context, "Please Chose A Photo");
                            return;
                          }
                          cubit.addHeader(path: path!, isVideo: false);
                        } else if (pageController.index == 1) {
                          if (formKey.currentState!.validate()) {
                            // Process form data here
                            String data = titleController.text;
                            if (data.endsWith("/")) {
                              data = data.substring(0, data.length - 1);
                            }
                            cubit.addHeader(
                                path: data, isVideo: true);
                          }
                        }
                      },
                      boarderRadius: 20,
                      title: "Add Announcment",
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
