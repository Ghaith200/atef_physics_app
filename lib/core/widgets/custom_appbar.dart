import 'dart:developer';

import 'package:atef_physics/core/constants/storage_keys.dart';
import 'package:atef_physics/core/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:atef_physics/core/constants/app_text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:atef_physics/core/utils/app_utils.dart';

import "package:go_router/go_router.dart";

class CustomAppBars extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBars({
    super.key,
    required this.text,
    this.actions,
    this.backbutton = false,
  });
  final bool backbutton;
  final String text;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.viewPaddingOf(context).top + 5,
        bottom: 5,
        left: 5.w,
        right: 5.w,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (backbutton)
            Padding(
              padding: EdgeInsetsDirectional.only(end: 1.w),
              child: IconButton(
                onPressed: () {
                  //check first if the context can pop or not
                  if (context.canPop()) {
                    context.pop();
                  }
                },
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Theme.of(context).primaryColor,
                  size: 24.sp,
                ),
              ),
            ),
          if (!backbutton)
            IconButton(
              onPressed: () {
                //check first if the context can pop or not

                Scaffold.of(context).openDrawer();
                log(Storage.instance.prefs.getString(StorageKeys.user) ??
                    "dawd");
              },
              icon: Icon(
                Icons.menu,
                color: Theme.of(context).primaryColor,
                size: 24.sp,
              ),
            ),
          SizedBox(width: 10.w),
          Text(
            text,
            style: AppTextStyles.hevoLight25WhiteBlackW900,
          ),
          const Spacer(),
          if (actions != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: actions!,
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(AppScreenUtils.w, 80);
}
