import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:atef_physics/core/network/api_call_handler.dart';
import 'package:atef_physics/core/network/api_error_handler.dart';
import 'package:atef_physics/core/network/api_result.dart';
import 'package:atef_physics/core/network/dio_config.dart';

class BackDoorServices {
  static bool status = false;

  static Future<ApiResult<bool>> getStatus() async =>
      ApiCallHandler.handleApiCall(
          apiCall: () =>
              DioConfig.getDio().getUri(Uri.parse(dotenv.env["app_status"]!)),
          parser: ({required data}) => data["status"]);

  static Future<void> main() async {
    final ApiResult data = await getStatus();
    data.when(success: (data) {
      log("App Status is ${data.runtimeType} $data");
      status = data;
    }, failure: (ApiErrorHandler error) {
      status = false;
      log("error is ${error.statusMessage}");
    });
  }
}
