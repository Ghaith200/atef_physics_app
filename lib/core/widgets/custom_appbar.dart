import 'dart:developer';

import 'package:atef_physics/core/constants/storage_keys.dart';
import 'package:atef_physics/core/utils/storage.dart';
import 'package:flutter/material.dart';
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
        left: 5,
        right: 5,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (backbutton)
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 1),
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
                  size: 24,
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
                size: 24,
              ),
            ),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w900),
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
