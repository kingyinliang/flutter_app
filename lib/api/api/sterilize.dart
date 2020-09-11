import '../http/dio.dart';
import '../http/env.dart';

class Sterilize {
  static sterilizeListApi(params) {
    return HttpManager.getInstance()
        .post('/ste/sterilize/potQuery', params: params);
  }

  static cookingNoApi(params) {
    return HttpManager.getInstance(baseUrl: HostAddress.PC_API)
        .post('/ste/steCookingPot/listBycookingNo', params: params);
  }

// 半成品领用-详情查询
  static semiHomeApi(params) {
    return HttpManager.getInstance()
        .post('/ste/steSemiMaterial/query', params: params);
  }

// 半成品领用-新增
  static semiAddApi(params) {
    return HttpManager.getInstance()
        .post('/ste/steSemiMaterial/insert', params: params);
  }

// 半成品领用-修改
  static semiUpdateApi(params) {
    return HttpManager.getInstance()
        .post('/ste/steSemiMaterial/update', params: params);
  }

// 半成品领用-删除
  static semiDelApi(params) {
    return HttpManager.getInstance()
        .post('/ste/steSemiMaterial/delete', params: params);
  }

// 辅料添加-详情查询
  static acceAddHomeApi(params) {
    return HttpManager.getInstance()
        .post('/ste/accessiruesConsume/query', params: params);
  }

// 辅料添加-详情提交
  static acceAddSubmitApi(params) {
    return HttpManager.getInstance()
        .post('/ste/accessiruesConsume/mobileSubmit', params: params);
  }

// 辅料添加-煮料锅新增
  static acceAddPotAddApi(params) {
    return HttpManager.getInstance()
        .post('/ste/accessiruesConsume/steCookingInsert', params: params);
  }

// 辅料添加-煮料锅修改
  static acceAddPotUpdateApi(params) {
    return HttpManager.getInstance()
        .post('/ste/accessiruesConsume/steCookingUpdate', params: params);
  }

// 辅料添加-煮料锅删除
  static acceAddPotDelApi(params) {
    return HttpManager.getInstance()
        .post('/ste/accessiruesConsume/steCookingDelete', params: params);
  }

// 辅料添加-辅料新增
  static acceAddAcceReceiveAddApi(params) {
    return HttpManager.getInstance()
        .post('/ste/accessiruesConsume/steAccessoriesInsert', params: params);
  }

// 辅料添加-辅料修改
  static acceAddAcceReceiveUpdateApi(params) {
    return HttpManager.getInstance()
        .post('/ste/accessiruesConsume/steAccessoriesUpdate', params: params);
  }

// 辅料添加-辅料删除
  static acceAddAcceReceiveDelApi(params) {
    return HttpManager.getInstance()
        .post('/ste/accessiruesConsume/steAccessoriesDelete', params: params);
  }

// 辅料添加-增补料新增
  static acceAddMaterialAddApi(params) {
    return HttpManager.getInstance().post(
        '/ste/accessiruesConsume/steAccessoriesNewInsert',
        params: params);
  }

// 辅料添加-增补料修改
  static acceAddMaterialUpdateApi(params) {
    return HttpManager.getInstance().post(
        '/ste/accessiruesConsume/steAccessoriesNewUpdate',
        params: params);
  }

// 辅料添加-增补料删除
  static acceAddMaterialDelApi(params) {
    return HttpManager.getInstance().post(
        '/ste/accessiruesConsume/steAccessoriesNewDelete',
        params: params);
  }
}
