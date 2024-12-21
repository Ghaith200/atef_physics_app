import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:atef_physics/core/constants/app_text_styles.dart';
import 'package:atef_physics/core/utils/app_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ApiErrorHandler {
  final int statusCode;
  final dynamic statusMessage;
  final bool success;

  ApiErrorHandler(
      {required this.statusCode,
      required this.statusMessage,
      required this.success});

  void showError(context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        // If statusMessage is a String, show it directly
        if (statusMessage is String) {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(
              backgroundColor: Colors.grey.shade200.withOpacity(0.5),
              boxShadow: [
                BoxShadow(color: Colors.grey.shade200.withOpacity(0.5))
              ],
              icon: const SizedBox(),
              textStyle: AppTextStyles.hevoLight14greykW500,
              message: statusMessage,
            ),
          );
        } else if (statusMessage is Map<String, dynamic>) {
          // If it's a Map, display each error one by one
          Map<String, dynamic> statusMessageMap = statusMessage;
          statusMessageMap.forEach(
            (key, value) {
              if (value is List) {
                for (var msg in value) {
                  Future.delayed(const Duration(milliseconds: 500), () {
                    AppSnackBar.showSnackBar(context, msg);
                  });
                }
              } else {
                AppSnackBar.showSnackBar(context, value);
              }
            },
          );
        } else {
          AppSnackBar.showSnackBar(context, 'unknown_error_occured'.tr);
        }
      },
    );
  }
}
