import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import '../models/token_model.dart';
import '../services/token_service.dart';
import '../tools/app_error_handler.dart';
import 'app_links.dart';

class TokenInterceptor extends Interceptor {
  final TokenService tokenService = Get.find();

  TokenInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      String refresh = tokenService.tokenModel!.rToken;
      var dio = Dio(
        BaseOptions(
          baseUrl: AppLinks.baseUrlProd,
        ),
      );

      var response = await dio
          .post(AuthLinks.refresh, data: {'refreshToken': refresh}).onError(
        (error, stackTrace) {
          ErrorHandler.handle(error);
          return Response(requestOptions: RequestOptions(path: 'error'));
        },
      );
      // if response is good we get new access token need to replace
      //  update refresh token in local storage and profile controller

      TokenModel tokenModel = TokenModel(
        aToken: response.data['data'],
        rToken: tokenService.tokenModel!.rToken,
      );
      tokenService.saveNewAccessToken(tokenModel);
      final requestOptions = err.requestOptions;

      final newOptions = requestOptions.copyWith(
        headers: {
          'Authorization': 'Bearer ${response.data['data']}',
        },
      );
      final retryResponse = await dio.fetch(newOptions);
      return handler.resolve(retryResponse);
    }
    super.onError(err, handler);
  }
}
