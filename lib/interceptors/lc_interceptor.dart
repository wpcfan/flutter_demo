import 'package:demo/config.dart';
import 'package:dio/dio.dart';

class LeanCloudInterceptor extends Interceptor {
  final String appId;
  final String appKey;
  final String? sessionToken;

  LeanCloudInterceptor(this.sessionToken,
      {required this.appId, required this.appKey});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.uri.host == lcApiBase) {
      options.headers['X-LC-Id'] = appId;
      options.headers['X-LC-Key'] = appKey;
      if (sessionToken != null) {
        options.headers['X-LC-Session'] = sessionToken!;
      }
    }
    super.onRequest(options, handler);
  }
}
