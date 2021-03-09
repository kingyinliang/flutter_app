import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:dfmdsapp/utils/storage.dart';
import 'package:dfmdsapp/utils/toast.dart';
import 'package:dfmdsapp/main.dart';

import './env.dart';
import './httpCode.dart';
import './socket.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 50,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/assets/images/loading.gif'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class HttpManager {
  final String _addressBaseUrl = HostAddress.APP_API;
  final int _connectTimeout = 600000;
  final int _receiveTimeout = 3000;
  int netLoadingCount = 0;

  static HttpManager _instance = HttpManager._internal();
  Dio _dio;
  BaseOptions _options;

  // 单例模式
  factory HttpManager() => _instance;
  // ignore: missing_return
  static HttpManager getInstance({String baseUrl}) {
    if (baseUrl == null) {
      return _instance._normal();
    } else {
      return _instance._baseUrl(baseUrl);
    }
  }

  // 初始化
  // ignore: unused_element
  HttpManager._internal() {
    if (null == _dio) {
      EasyLoading.instance
        ..displayDuration = const Duration(milliseconds: 2000);
      EasyLoading.instance..loadingStyle = EasyLoadingStyle.custom;
      EasyLoading.instance..backgroundColor = Color(0x66000000);
      EasyLoading.instance..textColor = Colors.white;
      EasyLoading.instance..userInteractions = false;
      EasyLoading.instance..indicatorColor = Colors.white;
      EasyLoading.instance..progressColor = Colors.white;
      _options = BaseOptions(
        baseUrl: _addressBaseUrl,
        connectTimeout: _connectTimeout,
        receiveTimeout: _receiveTimeout,
      );

      _dio = new Dio(_options);

      _dio.interceptors.add(CookieManager(CookieJar()));
      _dio.interceptors.add(LogsInterceptors());
      _dio.interceptors.add(ResponseInterceptors());
    }
  }

  //用于指定特定域名
  HttpManager _baseUrl(String baseUrl) {
    if (_dio != null) {
      _dio.options.baseUrl = baseUrl;
    }
    return this;
  }

  //一般请求，默认域名
  HttpManager _normal() {
    if (_dio != null) {
      if (_dio.options.baseUrl != _addressBaseUrl) {
        _dio.options.baseUrl = _addressBaseUrl;
      }
    }
    return this;
  }

  // get
  get(url, {params, options, withLoading = true}) async {
    showLoading(withLoading);
    Response response;
    var net = await SharedUtil.instance.getStorage('netStatus');
    if (net == false) {
      endLoading();
      return onRequest(Response(data: {'msg': "无网络"}));
    }
    try {
      response = await _dio.get(url, queryParameters: params, options: options);
      hideLoading(withLoading);
    } on DioError catch (e) {
      endLoading();
      EasyLoading.showInfo('未知错误', duration: Duration(milliseconds: 2000));
      formatError(e);
    }
    return onRequest(response);
  }

  // post
  post(url, {params, options, withLoading = true}) async {
    showLoading(withLoading);
    Response response;
    var net = await SharedUtil.instance.getStorage('netStatus');
    if (net == false) {
      endLoading();
      return onRequest(Response(data: {'msg': "无网络"}));
    }
    try {
      response = await _dio.post(url, data: params, options: options);
      hideLoading(withLoading);
    } on DioError catch (e) {
      endLoading();
      EasyLoading.showInfo('未知错误', duration: Duration(milliseconds: 2000));
      formatError(e);
    }
    return onRequest(response);
  }

  // ignore: missing_return
  Future updateToken() async {
    _dio.options.headers['Authorization'] =
        await SharedUtil.instance.getStorage('token');
  }

  // loding
  showLoading(withLoading) {
    if (withLoading && netLoadingCount == 0) {
      EasyLoading.show(status: '加载中...', indicator: LoadingWidget());
    }
    netLoadingCount++;
  }

  hideLoading(withLoading) {
    if (netLoadingCount <= 0) return;
    netLoadingCount--;
    if (withLoading && netLoadingCount == 0) {
      endLoading();
    }
  }

  endLoading() async {
    netLoadingCount = 0;
    // ignore: await_only_futures
    await EasyLoading.dismiss(animation: false);
  }

  // 响应拦截
  Future onRequest(response) async {
    final _com = Completer();
    final _future = _com.future;
    if (response.data['code'] == ResultCode.SUCCESS) {
      _com.complete(response.data);
      return _future;
    } else if (response.data['code'] == 0) {
      _com.complete(response.data);
      return _future;
    } else if (response.data['code'] == ResultCode.EXPIRED_TOKEN) {
      endLoading();
      WebSocketManager.dispos();
      var loginStatus = await SharedUtil.instance.getStorage('loginStatus');
      if (loginStatus == false || loginStatus == null) {
        Future.delayed(Duration.zero, () {
          Router.navigatorKey.currentState
              .pushNamedAndRemoveUntil('/login', (route) => false);
        });
      }

      _com.complete(response.data);
      return _future;
    } else {
      endLoading();
      infoToast(msg: '${response.data['msg']}');
      _com.completeError(response);
      return _future;
    }
  }

  void formatError(DioError e) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      infoToast(msg: "连接超时");
      print("连接超时");
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      infoToast(msg: "请求超时");
      print("请求超时");
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      infoToast(msg: "响应超时");
      print("响应超时");
    } else if (e.type == DioErrorType.RESPONSE) {
      infoToast(msg: "出现异常");
      print("出现异常");
    } else if (e.type == DioErrorType.CANCEL) {
      infoToast(msg: "请求取消");
      print("请求取消");
    } else {
      infoToast(msg: "未知错误");
      print("未知错误");
    }
  }
}

// 日志拦截
class LogsInterceptors extends Interceptor {
  @override
  Future onRequest(RequestOptions options) async {
    if (options.headers['Authorization'] is String) {
    } else if (await SharedUtil.instance.getStorage('token') is String) {
      await HttpManager.getInstance().updateToken();
      options.headers['Authorization'] =
          await SharedUtil.instance.getStorage('token');
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
    Map httpLogMap = Map();
    httpLogMap.putIfAbsent("requestUrl", () => "${response.request.uri}");
    httpLogMap.putIfAbsent(
        "requestQueryParameters", () => response.request.queryParameters);
    httpLogMap.putIfAbsent("respondData", () => response.data);
    print('\n==================== RESPONSE ====================\n');
    printJson(httpLogMap);
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    print('\n==================== ERROR ====================\n');
    print(err);
    return super.onError(err);
  }

  //带有首行缩进的Json格式
  static JsonEncoder encoder = JsonEncoder.withIndent('  ');

  /// 单纯的Json格式输出打印
  static void printJson(Object object) {
    try {
      var encoderString = encoder.convert(object);
      // print(encoderString);
      // 不使用print()方法是因为这是单条输出，如果过长无法显示全
      // 所以使用debugPrint()
      debugPrint(encoderString);
      // 下面这语句的效果与debugPrint 相同
      //encoderString.split('\n').forEach((element) => print(element));
    } catch (e) {
      print(e);
    }
  }
}

// 响应拦截
class ResponseInterceptors extends InterceptorsWrapper {
  @override
  onResponse(Response response) {
    return super.onResponse(response);
  }
}
