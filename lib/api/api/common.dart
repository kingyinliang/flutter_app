import '../http/dio.dart';

class Common {
  static loginApi(params) {
    return HttpManager.getInstance().post('/sysUser/login', params: params);
  }
}
