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

// 半成品领用-提交
  static semiSubmitApi(params) {
    return HttpManager.getInstance()
        .post('/ste/steSemiMaterial/mobileSubmit', params: params);
  }

// 半成品领用-新增
  static semiAddApi(params) {
    return HttpManager.getInstance()
        .post('/ste/steSemiMaterial/insert', params: params);
  }

// 半成品领用-复制
  static semiCopyApi(params) {
    return HttpManager.getInstance()
        .post('/ste/steSemiMaterial/mobileSopy', params: params);
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

// 辅料添加-增补料物料
  static acceAddMaterialQueryApi(params) {
    return HttpManager.getInstance(baseUrl: HostAddress.PC_API)
        .post('/ste/steSpeAccessories/listByType', params: params);
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

  /////////////////////////// 工艺 start  ////////////////////////////////////////////////
  // 列表 (type: not  save  submit)
  static sterilizeCraftListApi(params) {
    return HttpManager.getInstance()
        .post('/ste/steProcessorControl/processorQuery', params: params);
  }

  // 详情列表
  static sterilizeCraftMaterialListApi(params) {
    return HttpManager.getInstance()
        .post('/ste/steProcessorControl/query', params: params);
  }

  static sterilizeCraftMaterialListApi2(params) {
    return HttpManager.getInstance().post('/steCraft/query', params: params);
  }

  // 提交
  static sterilizeCraftMaterialTimeSubmitApi(params) {
    return HttpManager.getInstance()
        .post('/ste/steProcessorControl/mobileSubmit', params: params);
  }

  // 杀菌时间添加
  static sterilizeCraftMaterialTimeInsertApi(params) {
    return HttpManager.getInstance()
        .post('/ste/steProcessorControl/timeInsert', params: params);
  }

  // 杀菌时间修改
  static sterilizeCraftMaterialTimeUpdateApi(params) {
    return HttpManager.getInstance()
        .post('/ste/steProcessorControl/timeUpdate', params: params);
  }

  // 杀菌时间删除
  static sterilizeCraftMaterialTimeDelApi(params) {
    return HttpManager.getInstance()
        .post('/ste/steProcessorControl/timeDelete', params: params);
  }

  // 杀菌升温添加
  static sterilizeCraftMaterialInsertApi(params) {
    return HttpManager.getInstance()
        .post('/ste/steProcessorControl/insert', params: params);
  }

  // 杀菌升温修改
  static sterilizeCraftMaterialUpdateApi(params) {
    return HttpManager.getInstance()
        .post('/ste/steProcessorControl/update', params: params);
  }

  ////////////////////////////// 工艺 end ////////////////////////////////////////
  // 异常 start
  // home查询
  static sterilizeExceptionHomeListApi(params) {
    return HttpManager.getInstance()
        .post('/ste/steException/potOrderQuery', params: params);
  }

  // list异常查询
  static sterilizeExceptionDetailListApi(params) {
    return HttpManager.getInstance()
        .post('/ste/steException/query', params: params);
  }

  // list异常添加
  static sterilizeExceptionDetailInsertApi(params) {
    return HttpManager.getInstance()
        .post('/ste/steException/insert', params: params);
  }

  // list异常修改
  static sterilizeExceptionDetailUpdateApi(params) {
    return HttpManager.getInstance()
        .post('/ste/steException/update', params: params);
  }

  // list异常删除
  static sterilizeExceptionDetailDeleteApi(params) {
    return HttpManager.getInstance()
        .post('/ste/steException/delete', params: params);
  }

  // list文本查询
  static sterilizeExceptionDetailTextApi(params) {
    return HttpManager.getInstance().post('/ste/steText/query', params: params);
  }

  // list文本添加
  static sterilizeExceptionDetailTextInsertApi(params) {
    return HttpManager.getInstance()
        .post('/ste/steText/insert', params: params);
  }

  // list文本修改
  static sterilizeExceptionDetailTextUpdateApi(params) {
    return HttpManager.getInstance()
        .post('/ste/steText/update', params: params);
  }
}
