import 'dart:async';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import './env.dart';
import './httpCode.dart';
import '../../utils/storage.dart';
import '../../main.dart';

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

  // 初始化
  HttpManager() {
    _options = BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
    );

    _dio = new Dio(_options);

    _dio.interceptors.add(CookieManager(CookieJar()));
    _dio.interceptors.add(LogsInterceptors());
    _dio.interceptors.add(ResponseInterceptors());
  }

  // get
  get(url, {params, options, withLoading = true}) async {
    Response response;
    try {
      response = await _dio.get(url, queryParameters: params, options: options);
    } on DioError catch (e) {
      formatError(e);
    }
    return onRequest(response);
  }

  // post
  post(url, {params, options, withLoading = true}) async {
    Response response;
    try {
      response = await _dio.post(url, data: params, options: options);
    } on DioError catch (e) {
      formatError(e);
    }
    return onRequest(response);
  }

  // ignore: missing_return
  Future updateToken() async {
    _dio.options.headers['Authorization'] = await getStorage('token');
  }

  // 响应拦截
  Future onRequest(response) {
    final _com = Completer();
    final _future = _com.future;
    if (response.data['code'] == ResultCode.SUCCESS) {
      _com.complete(response.data);
      return _future;
    } else if (response.data['code'] == ResultCode.EXPIRED_TOKEN) {
      Router.navigatorKey.currentState
          .pushNamedAndRemoveUntil('/', (route) => false);
      _com.complete(response.data);
      return _future;
    } else {
      _com.completeError(response);
      return _future;
    }
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
  Future onRequest(RequestOptions options) async {
    if (options.headers['Authorization'] is String) {
    } else if (await getStorage('token') is String) {
      await HttpManager.getInstance().updateToken();
      options.headers['Authorization'] = await getStorage('token');
    }

    String requestStr = "\n==================== REQUEST ====================\n"
        "- URL:${options.baseUrl + options.path}\n"
        "- METHOD: ${options.method}\n";
    requestStr += "- HEADER:\n${options.headers}\n";
    final data = options.data;
    if (data != null) {
      if (data is Map) {
        requestStr += "- BODY:\n$data\n";
      } else if (data is FormData) {
        final formDataMap = Map()
          ..addEntries(data.fields)
          ..addEntries(data.files);
        requestStr += "- BODY:\n$formDataMap\n";
      } else
        requestStr += "- BODY:\n${data.toString()}\n";
    }
    print(requestStr);
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    String responseStr =
        "\n==================== RESPONSE ====================\n"
        "- URL:${response.request.uri}\n";

    if (response.data != null) {
      responseStr += "- BODY:\n ${response.data}";
    }
    print(responseStr);
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    print('\n==================== ERROR ====================\n');
    print(err);
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
