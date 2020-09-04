import '../http/dio.dart';

class Sterilize {
  static acceAddHomeApi(params) {
    return HttpManager.getInstance()
        .post('/ste/accessiruesConsume/query', params: params);
  }
}
