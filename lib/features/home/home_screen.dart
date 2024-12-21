import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:atef_physics/core/widgets/custom_appbar.dart';
import 'package:atef_physics/core/widgets/custom_textfield.dart';
import 'package:atef_physics/features/home/widgets/custom_chat_widget.dart';
import 'package:atef_physics/features/home/widgets/status_list_view_widget.dart';
import 'package:atef_physics/gen/assets.gen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String id = "/HomeScreen";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 15.sp),
      child: Scaffold(
        appBar: CustomAppBars(
          text: "Chats",
          actions: <Widget>[
            IconButton(
                icon: Assets.images.icons.cameraIcon.svg(),
                onPressed: () => log('Camera Icon Pressed'),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.onSurface.withOpacity(.3),
                )),
            IconButton(
              icon: Assets.images.icons.editIcon.svg(),
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Theme.of(context).colorScheme.onSurface.withOpacity(.3),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            // SizedBox(height: 20.h),
            //! To BE Fixed Later
            const CustomTextFormField(
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                label: "Search"),
            //!
            SizedBox(height: 12.h),
            const StatusListViewWidget(),

            Expanded(
                child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 10.h),
                    itemCount: 20,
                    itemBuilder: (context, index) => const CustomChatWidget()))
          ],
        ),
      ),
    );
  }
}
