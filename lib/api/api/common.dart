import '../http/dio.dart';

class Common {
  static loginApi(params) {
    return HttpManager.getInstance()
        .post('/sysUser/mobile/login', params: params);
  }

  static quitLoginApi() {
    return HttpManager.getInstance().get('/sysUser/quit');
  }

  static getMenuApi() {
    return HttpManager.getInstance().get('/sysUser/userRole/mobile/menuQuery');
  }
}
