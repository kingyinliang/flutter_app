import '../http/dio.dart';
import '../http/env.dart';

class KojiMaking {
  static sterilizeListApi(params) {
    return HttpManager.getInstance(baseUrl: HostAddress.PC_API)
        .post('/ste/sterilize/potQuery', params: params);
  }
}
