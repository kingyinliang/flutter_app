import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import './env.dart';
import './httpCode.dart';

class HttpManager {
  final String _baseUrl = HostAddress.DEV_API;
  final int _connectTimeout = 5000;
  final int _receiveTimeout = 3000;

  static HttpManager _instance;
  Dio _dio;
  BaseOptions _options;

  // 单例模式
  // ignore: missing_return
  static HttpManager getInstance() {
    if (null == _instance) {
      _instance = HttpManager();
      return _instance;
    }
    return _instance;
  }

  HttpManager() {
    _options = BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
    );

    _dio = new Dio(_options);

    _dio.options.headers['Authorization'] = '111';

    _dio.interceptors.add(CookieManager(CookieJar()));
    _dio.interceptors.add(LogsInterceptors());
    _dio.interceptors.add(ResponseInterceptors());
  }

  get(url, {params, options, withLoading = true}) async {
    Response response;
    try {
      response = await _dio.get(url, queryParameters: params, options: options);
    } on DioError catch (e) {
      formatError(e);
    }
    return response.data;
  }

  post(url, {params, options, withLoading = true}) async {
    Response response;
    try {
      response =
          await _dio.post(url, queryParameters: params, options: options);
    } on DioError catch (e) {
      formatError(e);
    }
    return response.data;
  }

  void formatError(DioError e) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      print("连接超时");
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      print("请求超时");
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      print("响应超时");
    } else if (e.type == DioErrorType.RESPONSE) {
      print("出现异常");
    } else if (e.type == DioErrorType.CANCEL) {
      print("请求取消");
    } else {
      print("未知错误");
    }
  }
}

// 日志拦截
class LogsInterceptors extends Interceptor {
  @override
  Future onRequest(RequestOptions options) {
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    print(response.request.uri);
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    print('error');
    return super.onError(err);
  }
}

// 响应拦截
class ResponseInterceptors extends InterceptorsWrapper {
  @override
  onResponse(Response response) {
    return super.onResponse(response);
  }
}
