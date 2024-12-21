import 'package:flutter/material.dart';
import 'package:atef_physics/core/constants/app_text_styles.dart';
import 'package:atef_physics/core/utils/app_colors.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AppSnackBar {
  AppSnackBar._();

  /// Shows a snack bar at the top of the screen with the given message.
  ///
  /// This snack bar is used to show errors, warnings, or other important messages.
  /// The color of the snack bar is grey, and the font is black and 15pt.
  /// The snack bar is dismissable by tapping anywhere on the screen.
  ///
  /// If [onTap] is given, it is called when the snack bar is tapped.
  ///
  static void showSnackBar(context, msg, [void Function()? onTap]) {
    return showTopSnackBar(
      onTap: onTap,
      Overlay.of(context),
      CustomSnackBar.error(
        backgroundColor: AppColors.scheme.primary.withOpacity(.5),
        boxShadow: [
          BoxShadow(color: Theme.of(context).cardColor.withOpacity(.5))
        ],
        icon: const SizedBox(),
        textStyle: AppTextStyles.hevoLight20WhiteBlackW400,
        message: msg,
      ),
    );
  }
}
