import 'package:dio/dio.dart';
import 'package:atef_physics/core/constants/api_endpoints.dart';

/// A configuration helper class for setting up a Dio client with caching, logging, and timeout functionality.
///
/// The `DioConfig` class ensures that network requests are handled efficiently by adding:
/// - A caching layer to store responses for offline usage and improved performance.
/// - A logging mechanism to track requests and responses for debugging.
/// - Timeout configurations for both connection and receiving data.
///
/// This class uses a private constructor to prevent instantiation and provides a static method [getDio] to return a fully configured Dio instance.
class DioConfig {
  /// Default timeout duration for connection and receive operations.
  ///
  /// The timeout is set to 10 seconds for both connecting to the server and receiving data.
  static const Duration _timeOut = Duration(seconds: 10000);

  // Private constructor to prevent instantiation of the class.
  DioConfig._();

  /// Returns a pre-configured Dio instance.
  ///
  /// The Dio instance is set up with:
  /// - Base URL from [AppStrings.baseUrl].
  /// - Timeout for both connection and receiving set to 10 seconds.
  /// - Default headers including `application/json` content type.
  /// - A logging interceptor to log errors, requests, and responses.
  /// - A cache interceptor to store responses in memory for offline use and performance improvements.
  ///
  /// ### Cache Configuration:
  /// - **Store**: Memory-based cache (`MemCacheStore`).
  /// - **Policy**: Always tries to fetch fresh data from the network (`CachePolicy.request`), but falls back to cache on certain errors.
  /// - **Error Handling**: Uses cache in case of errors except for 401 and 403 status codes.
  /// - **Cache Expiry**: Cached responses remain valid for 7 days.
  /// - **POST Requests**: Caching is disabled for POST requests.
  ///
  /// Returns:
  /// - `Dio`: A configured Dio client instance.
  ///
  /// Example usage:
  /// ```dart
  /// final Dio dio = DioConfig.getDio();
  /// final response = await dio.get('/endpoint');
  /// ```
  static Dio getDio() {
    // final cacheOptions = CacheOptions(
    //   store: MemCacheStore(),
    //   policy: CachePolicy.request,
    //   hitCacheOnErrorExcept: [401, 403, 422],
    //   maxStale: const Duration(days: 7),
    //   priority: CachePriority.normal,
    //   cipher: null,
    //   keyBuilder: CacheOptions.defaultCacheKeyBuilder,
    //   allowPostMethod: false,
    // );

    BaseOptions options = BaseOptions(
      baseUrl: ApiEndpoints.baseurl,
      connectTimeout: _timeOut,
      receiveTimeout: _timeOut,
      //added header (by waleed at 26/10/2024) for langauge to add only for one time.
      headers: {
        Headers.acceptHeader: Headers.jsonContentType,
        // 'Accept-Language': Get.locale!.languageCode,
        /**
         * HINT: PLEASE CHANGE THE TOKEN FROM STRING TO VARIABLE TO MAKE IT CHANGED AUTOMATICALLY DUE TO USER CREDENTIAL
         * changed the token string with my token to open
         * edited by naira ali[29/10/2024]
         */
        // "Authorization":
        //     "Bearer 103|QAEoCqcmB7aiVkzQqPjxhQX21vszGliFFLtNqKlU8429c136"
      },
    );

    final Dio dio = Dio(options)
      ..interceptors.addAll(
        [
          LogInterceptor(
            error: true,
            responseBody: true,
            requestBody: true,
            requestHeader: true,
            responseHeader: true,
            request: true,
          ),
          // DioCacheInterceptor(options: cacheOptions),
        ],
      );
    return dio;
  }
}
