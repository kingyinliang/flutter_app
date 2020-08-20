import '../http/dio.dart';

class Common {
  static loginApi(param) {
    return HttpManager.getInstance().post('/sysUser/login');
  }
}
