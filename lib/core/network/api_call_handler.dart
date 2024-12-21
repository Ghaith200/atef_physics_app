import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:atef_physics/core/network/api_error_handler.dart';
import 'package:atef_physics/core/network/api_result.dart';

/// A utility class for handling API calls with error management and response parsing.
///
/// The `ApiCallHandler` class provides a static method [handleApiCall] to manage
/// network requests, process their responses, and handle potential errors using
/// the Dio library. The result is wrapped in an [ApiResult] object, which represents
/// either success or failure, based on the status of the request.
///
/// This class has a private constructor to prevent instantiation and only allows
/// usage of the static method for API calls.
class ApiCallHandler {
  // Private constructor to prevent instantiation.
  ApiCallHandler._();

  /// Handles an API call and processes the response with error handling.
  ///
  /// This method performs the following steps:
  /// 1. Executes the [apiCall] function, which performs the actual network request.
  /// 2. If the request is successful (status code between 200 and 300), it calls
  ///    the [parser] function to parse the response data.
  /// 3. If the request fails (status codes outside the 2xx range), it catches the
  ///    error using Dio's `DioException` and returns an [ApiResult.failure].
  ///
  /// The method ensures a consistent pattern for handling API responses and errors.
  ///
  /// Example usage:
  /// ```dart
  /// final result = await ApiCallHandler.handleApiCall(
  ///   apiCall: () => dio.get('/endpoint'),
  ///   parser: ({required data}) => YourModel.fromJson(data),
  /// );
  /// ```
  ///
  /// Parameters:
  /// - `apiCall`: A required function that performs the API request and returns
  ///   a `Future<Response>`.
  /// - `parser`: A required function that takes the response data (`dynamic`) and
  ///   parses it into a model of type `T`.
  ///
  /// Returns:
  /// - `Future<ApiResult<T>>`: A `Future` that resolves to an `ApiResult` object
  ///   representing either a successful API call with parsed data, or a failure with
  ///   an error message.
  static Future<ApiResult<T>> handleApiCall<T>({
    required Future<Response> Function() apiCall,
    required T Function({required dynamic data}) parser,
  }) async {
    try {
      // Execute the API call.
      Response response = await apiCall();

      // Check if the status code indicates success (2xx range).
      if (response.statusCode! >= 200 || response.statusCode! <= 300) {
        // Parse the response data and return success result.
        log("-------status code------->\n${response.statusCode}");
        return ApiResult.success(parser(data: response.data));
      } else {
        log("-------status code------->\n${response.statusCode}");
        // If the status code is outside the 2xx range,
        return ApiResult.failure(
          ApiErrorHandler(
            statusCode: response.statusCode!,
            statusMessage: response.statusMessage!,
            success: false,
          ),
        );
      }
    } on DioException catch (e) {
      log("**********************************************");
      log(e.response.toString());
      // Handle DioException errors, such as network or server errors.
      ApiErrorHandler handler = ApiErrorHandler(
        statusCode: e.response?.statusCode ?? 500,
        statusMessage: e.response?.data['message'] ?? '',
        success: false,
      );
      // Return failure result with error handler details.
      return ApiResult.failure(handler);
    }
  }

  /// Handles API calls that do not require parsing, focusing on status code and message.
  ///
  /// This method executes the API call and checks the status code without parsing
  /// any body data, making it suitable for calls that only return a status message.
  ///
  /// Example usage:
  /// ```dart
  /// final result = await ApiCallHandler.handleApiCallWithoutParser(
  ///   apiCall: () => dio.get('/verification-endpoint'),
  /// );
  /// ```
  ///
  /// Returns:
  /// - `Future<ApiResult<void>>`: A `Future` that resolves to an `ApiResult` object
  ///   representing either a successful API call or a failure with an error message.
  static Future<ApiResult<void>> handleApiCallWithoutParser({
    required Future<Response> Function() apiCall,
  }) async {
    try {
      Response response = await apiCall();

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log("-------status code------->\n${response.statusCode}");
        return const ApiResult.success(null); // No data is returned here.
      } else {
        log("-------status code------->\n${response.statusCode}");
        return ApiResult.failure(
          ApiErrorHandler(
            statusCode: response.statusCode!,
            statusMessage: response.data['message']!,
            success: false,
          ),
        );
      }
    } on DioException catch (e) {
      ApiErrorHandler handler = ApiErrorHandler(
        statusCode: e.response?.statusCode ?? 0,
        statusMessage: e.response?.data['message'] ?? 'Unknown error',
        success: false,
      );
      return ApiResult.failure(handler);
    }
  }
}
