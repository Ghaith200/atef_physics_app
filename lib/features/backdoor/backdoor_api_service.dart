import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:atef_physics/core/network/api_call_handler.dart';
import 'package:atef_physics/core/network/api_result.dart';
import 'package:atef_physics/core/network/dio_config.dart';

class BackdoorApiService {
  static final Dio dio = DioConfig.getDio();

  static Future<ApiResult<bool>>
      getStatus() async => ApiCallHandler.handleApiCall(
          apiCall: () =>
              dio.getUri(Uri.dataFromString(dotenv.env["app_status"]!)),
          parser: ({required data}) => data);
}
