import '../http/dio.dart';
import '../http/env.dart';

class Common {
  // 登录
  static loginApi(params) {
    return HttpManager.getInstance()
        .post('/sysUser/mobile/login', params: params);
  }

// 退出
  static quitLoginApi() {
    return HttpManager.getInstance().get('/sysUser/quit');
  }

// 修改密码
  static updatePasswordApi(params) {
    return HttpManager.getInstance()
        .post('/sysUser/password/update', params: params);
  }

// 消息查询
  static msgQueryApi(params) {
    return HttpManager.getInstance(baseUrl: HostAddress.PC_API)
        .post('/msg/query', params: params);
  }

// 消息已读
  static msgReadApi(params) {
    return HttpManager.getInstance(baseUrl: HostAddress.PC_API)
        .post('/msg/read', params: params);
  }

// 首页菜单
  static getMenuApi() {
    return HttpManager.getInstance().get('/sysUser/userRole/mobile/menuQuery');
  }

// 字典下拉
  static dictDropDownQuery(params) {
    return HttpManager.getInstance(baseUrl: HostAddress.PC_API)
        .get('/sysDictItem/dropDown', params: params);
  }

// 容器下拉
  static holderDropDownQuery(params) {
    return HttpManager.getInstance(baseUrl: HostAddress.PC_API)
        .post('/sysHolder/dropDown', params: params);
  }

// orderBom
  static orderBoom(params) {
    return HttpManager.getInstance(baseUrl: HostAddress.PC_API)
        .post('/order/orderBom/queryList', params: params);
  }

// 根据物料获取单位
  static materialUnitQuery(params) {
    return HttpManager.getInstance(baseUrl: HostAddress.PC_API)
        .get('/sysMaterial/unit/dropDown', params: params);
  }

  // 班次拉取
  static classListQuery(params) {
    return HttpManager.getInstance(baseUrl: HostAddress.PC_API)
        .get('/sysDictItem/classes/dropDown', params: params);
  }

  // 设备下拉 无翻页
  static deviceListQuery(params) {
    return HttpManager.getInstance(baseUrl: HostAddress.PC_API)
        .post('/sysDevice/listByType', params: params);
  }

}
