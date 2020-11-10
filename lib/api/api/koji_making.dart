import '../http/dio.dart';

class KojiMaking {
// 制曲列表查询
  static kojiMakingList(params) {
    return HttpManager.getInstance()
        .post('/kojiOrderList/query', params: params);
  }

// 制曲订单精确查询
  static kojiMakingOrder(params) {
    return HttpManager.getInstance()
        .get('/kojiOrder/queryKojiOrder', params: params);
  }

// 制曲订单精确查询Sc
  static kojiMakingOrderSc(params) {
    return HttpManager.getInstance()
        .get('/kojiOrder/queryScOrder', params: params);
  }

// 蒸面记录首页查询
  static steamSideHome(params) {
    return HttpManager.getInstance()
        .get('/kojiSteamFlour/queryList', params: params);
  }

// 蒸面记录新增
  static steamSideAdd(params) {
    return HttpManager.getInstance()
        .post('/kojiSteamFlour/insert', params: params);
  }

// 蒸面记录修改
  static steamSideUpdate(params) {
    return HttpManager.getInstance()
        .post('/kojiSteamFlour/update', params: params);
  }

// 蒸面记录提交
  static steamSideSubmit(params) {
    return HttpManager.getInstance()
        .post('/kojiSteamFlour/submit', params: params);
  }

// 蒸豆记录首页查询
  static steamBeanRecordHome(params) {
    return HttpManager.getInstance()
        .get('/kojiSteamBean/queryList', params: params);
  }

// 蒸豆记录新增
  static steamBeanRecordAdd(params) {
    return HttpManager.getInstance()
        .post('/kojiSteamBean/insert', params: params);
  }

  // 蒸豆记录删除
  static steamBeanRecordDel(params) {
    return HttpManager.getInstance()
        .post('/kojiSteamBean/delete', params: params);
  }

// 蒸豆记录修改
  static steamBeanRecordUpdate(params) {
    return HttpManager.getInstance()
        .post('/kojiSteamBean/update', params: params);
  }

// 蒸豆记录提交
  static steamBeanRecordSubmit(params) {
    return HttpManager.getInstance()
        .post('/kojiSteamBean/submit', params: params);
  }

// 蒸豆硬度首页查询
  static steamBeanHardnessHome(params) {
    return HttpManager.getInstance()
        .get('/kojiSteamBeanHardness/queryList', params: params);
  }

// 蒸豆硬度新增
  static steamBeanHardnessAdd(params) {
    return HttpManager.getInstance()
        .post('/kojiSteamBeanHardness/insert', params: params);
  }

  // 蒸豆硬度删除
  static steamBeanHardnessDel(params) {
    return HttpManager.getInstance()
        .post('/kojiSteamBeanHardness/delete', params: params);
  }

// 蒸豆硬度修改
  static steamBeanHardnessUpdate(params) {
    return HttpManager.getInstance()
        .post('/kojiSteamBeanHardness/update', params: params);
  }

// 蒸豆硬度提交
  static steamBeanHardnessSubmit(params) {
    return HttpManager.getInstance()
        .post('/kojiSteamBeanHardness/submit', params: params);
  }

// 混合控制首页查询
  static steamHybridControlHome(params) {
    return HttpManager.getInstance()
        .get('/kojiSteamControl/queryList', params: params);
  }

// 混合控制新增
  static steamHybridControlAdd(params) {
    return HttpManager.getInstance()
        .post('/kojiSteamControl/insert', params: params);
  }

// 混合控制修改
  static steamHybridControlUpdate(params) {
    return HttpManager.getInstance()
        .post('/kojiSteamControl/update', params: params);
  }

// 混合控制提交
  static steamHybridControlSubmit(params) {
    return HttpManager.getInstance()
        .post('/kojiSteamControl/submit', params: params);
  }

// 异常记录查询
  static steamExeptionQuery(params) {
    return HttpManager.getInstance()
        .post('/koji/exception/query', params: params);
  }

// 异常记录保存
  static steamExeptionSave(params) {
    return HttpManager.getInstance()
        .post('/koji/exception/save', params: params);
  }

// 异常记录删除
  static steamExeptionDel(params) {
    return HttpManager.getInstance()
        .post('/koji/exception/delete', params: params);
  }

// 文本记录查询
  static steamTextQuery(params) {
    return HttpManager.getInstance().post('/koji/text/query', params: params);
  }

// 文本记录保存
  static steamTextSave(params) {
    return HttpManager.getInstance().post('/koji/text/save', params: params);
  }

  // 入曲查询
  static discInQuery(params) {
    return HttpManager.getInstance().get('/koji/discIn/query', params: params);
  }

  // 入曲保存
  static discInSaveQuery(params) {
    return HttpManager.getInstance().post('/koji/discIn/save', params: params);
  }

  // 入曲提交
  static discInSubmitQuery(params) {
    return HttpManager.getInstance().get('/koji/discIn/submit', params: params);
  }

  // 看曲查询
  static discLookQuery(params) {
    return HttpManager.getInstance().get('/koji/discGuard/query', params: params);
  }

  // 看曲异常查询
  static discLookExceptQuery(params) {
    return HttpManager.getInstance().get('/koji/discGuard/queryException', params: params);
  }

  // 看曲保存
  static discLookSave(params) {
    return HttpManager.getInstance().post('/koji/discGuard/save', params: params);
  }

  // 看曲删除
  static discLookDel(params) {
    return HttpManager.getInstance().get('/koji/discGuard/delete', params: params);
  }

  // 看曲异常保存
  static discLookExceptionSave(params) {
    return HttpManager.getInstance().get('/koji/discGuard/saveException', params: params);
  }

  // 看曲提交
  static discLookSubmit(params) {
    return HttpManager.getInstance().get('/koji/discGuard/submit', params: params);
  }
}
