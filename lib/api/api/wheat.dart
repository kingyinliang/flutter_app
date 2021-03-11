import '../http/dio.dart';
import '../http/env.dart';

class Wheat {
  static wheatOrderListApi(params) {
    return HttpManager.getInstance(baseUrl: HostAddress.APP_OLD_API)
        .post('/getOrderOnApp', params: params);
  }

  static wheatUploadApi(params) {
    return HttpManager.getInstance(baseUrl: HostAddress.APP_OLD_API)
        .post('/uploadDataOnApp', params: params);
  }

  static wheatBatchApi(params) {
    return HttpManager.getInstance(baseUrl: HostAddress.APP_OLD_API)
        .post('/createBatch', params: params);
  }
}
