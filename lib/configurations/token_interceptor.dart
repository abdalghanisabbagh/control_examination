import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import '../models/token_model.dart';
import '../services/token_service.dart';
import '../tools/app_error_handler.dart';
import 'app_links.dart';

/// Token Interceptor Class
/// This class will be used to intercept and handle the Unauthorized Error
/// It will get the new access token using the refresh token and retry the request
class TokenInterceptor extends Interceptor {
  final TokenService tokenService = Get.find();

  TokenInterceptor();

  /// This method will be called when the dio request fails
  /// It will check if the status code is 401 and if so it will get the new access token
  /// If the new access token is successfully retrieved it will retry the request
  /// This method will be called when the dio request fails
  /// It will check if the status code is 401 and if so it will get the new access token
  /// If the new access token is successfully retrieved it will retry the request
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Check if the status code is 401
    if (err.response?.statusCode == 401) {
      // Get the refresh token from the local storage
      String refresh = tokenService.tokenModel!.rToken;

      // Create a new dio instance for the refresh request
      var dio = Dio(
        BaseOptions(
          baseUrl: AppLinks.baseUrlDev,
        ),
      );

      // Try to get the new access token
      var response = await dio
          .post(AuthLinks.refresh, data: {'refreshToken': refresh}).onError(
        // Handle the error if the refresh request fails
        (error, stackTrace) {
          ErrorHandler.handle(error);
          return Response(requestOptions: RequestOptions(path: 'error'));
        },
      );

      // If the new access token is successfully retrieved
      if (response.data['data'] != null) {
        // Save the new access token in the local storage
        TokenModel tokenModel = TokenModel(
          aToken: response.data['data'],
          rToken: tokenService.tokenModel!.rToken,
        );
        tokenService.saveNewAccessToken(tokenModel);

        // Get the original request options
        final requestOptions = err.requestOptions;

        // Update the request headers with the new access token
        final newOptions = requestOptions.copyWith(
          headers: {
            'Authorization': 'Bearer ${response.data['data']}',
          },
        );

        // Retry the request with the new access token
        final retryResponse = await dio.fetch(newOptions);
        return handler.resolve(retryResponse);
      }
    }
    // If the status code is not 401 call the super method
    super.onError(err, handler);
  }
}
