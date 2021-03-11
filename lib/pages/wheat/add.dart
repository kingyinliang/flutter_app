import 'package:dfmdsapp/utils/index.dart';

class WheatAddPage extends StatefulWidget {
  final arguments;

  WheatAddPage({Key key, this.arguments}) : super(key: key);

  @override
  _WheatAddPageState createState() => _WheatAddPageState();
}

class _WheatAddPageState extends State<WheatAddPage> {
  Map<String, dynamic> formMap = {
    'wheatDeviceId': '',
    'wheatDeviceName': '',
    'flourDeviceId': '',
    'flourDeviceName': '',
    'inPortBatch': '',
    'startWeight': '',
    'endWeight': '',
    'inPortWeight': '',
  };
  List orderList = [];
  List batchList = [];
  List wheatDeviceList = [];
  List flourDeviceList = [];

  _submitForm() async {
    if (formMap['wheatDeviceId'] == null ||
        formMap['wheatDeviceId'] == '' ||
        formMap['flourDeviceId'] == null ||
        formMap['flourDeviceId'] == '' ||
        formMap['inPortBatch'] == null ||
        formMap['inPortBatch'] == '' ||
        formMap['startWeight'] == null ||
        formMap['startWeight'] == '' ||
        formMap['endWeight'] == null ||
        formMap['endWeight'] == '') {
      $warningToast(context, msg: '请填写必填项');
      return;
    }
    formMap['endWeight'] = formMap['endWeight'].toString();
    formMap['startWeight'] = formMap['startWeight'].toString();
    if (int.parse(formMap['endWeight']) - int.parse(formMap['startWeight']) <
        0) {
      EasyLoading.showError('起始数不能大于结束数');
      return;
    }
    formMap['inPortWeight'] =
        int.parse(formMap['endWeight']) - int.parse(formMap['startWeight']);
    var userData = await SharedUtil.instance.getMapStorage('userData');
    formMap['changer'] = userData['realName'] + '（' + userData['workNum'] + '）';
    orderList[widget.arguments['orderIndex']]['isModified'] = true;
    // 新增修改
    if (widget.arguments['tableIndex'] != null) {
      // 修改
      orderList[widget.arguments['orderIndex']]['inList']
          [widget.arguments['tableIndex']] = formMap;
      await SharedUtil.instance.saveMapStorage('orderList', orderList);
      Navigator.pop(context, true);
    } else {
      // 新增
      formMap['orderId'] = orderList[widget.arguments['orderIndex']]
          ['pkgOrderEntity']['orderId'];
      formMap['creator'] =
          userData['realName'] + '（' + userData['workNum'] + '）';
      orderList[widget.arguments['orderIndex']]['inList'].add(formMap);
      await SharedUtil.instance.saveMapStorage('orderList', orderList);
      Navigator.pop(context, true);
    }
  }

  _setBatch() {
    if (formMap['flourDeviceId'] != '' && formMap['wheatDeviceId'] != '') {
      List sole = batchList
          .where((e) =>
              e['littleHolderId'] == formMap['flourDeviceId'] &&
              e['holderId'] == formMap['wheatDeviceId'])
          .toList();
      formMap['inPortBatch'] = sole[0]['batch'];
      setState(() {});
    }
  }

  Widget formWidget() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
      padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
      child: Column(
        children: <Widget>[
          SelectWidget(
            label: '麦粉罐',
            prop: formMap['flourDeviceId'].toString(),
            requiredFlg: true,
            options: flourDeviceList,
            optionsLabel: 'holderName',
            optionsval: 'holderId',
            onChange: (val) {
              formMap['flourDeviceId'] = val['holderId'];
              formMap['flourDeviceName'] = val['holderName'];
              _setBatch();
              setState(() {});
            },
          ),
          SelectWidget(
            label: '粮仓号',
            prop: formMap['wheatDeviceId'].toString(),
            requiredFlg: true,
            options: wheatDeviceList,
            optionsLabel: 'holderName',
            optionsval: 'holderId',
            onChange: (val) {
              formMap['wheatDeviceId'] = val['holderId'];
              formMap['wheatDeviceName'] = val['holderName'];
              _setBatch();
              setState(() {});
            },
          ),
          InputWidget(
            label: '入库批次',
            keyboardType: 'number',
            prop: formMap['inPortBatch'].toString(),
            requiredFlg: true,
            onChange: (val) {
              formMap['inPortBatch'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '起始数',
            keyboardType: 'number',
            prop: formMap['startWeight'].toString(),
            requiredFlg: true,
            onChange: (val) {
              formMap['startWeight'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '结束数',
            keyboardType: 'number',
            prop: formMap['endWeight'].toString(),
            requiredFlg: true,
            onChange: (val) {
              formMap['endWeight'] = val;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  _init() async {
    batchList = await SharedUtil.instance.getMapStorage('batchList');
    wheatDeviceList =
        await SharedUtil.instance.getMapStorage('wheatDeviceList');
    flourDeviceList =
        await SharedUtil.instance.getMapStorage('flourDeviceList');
    orderList = await SharedUtil.instance.getMapStorage('orderList');
    if (widget.arguments['tableIndex'] != null) {
      formMap = jsonDecode(jsonEncode(orderList[widget.arguments['orderIndex']]
          ['inList'][widget.arguments['tableIndex']]));
    }
  }

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () => setState(() {
        _init();
      }),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MdsAppBarWidget(
          titleData: widget.arguments['tableIndex'] == null ? '入库新增' : '入库修改'),
      backgroundColor: Color(0xFFF5F5F5),
      body: ListView(
        children: <Widget>[
          formWidget(),
          SizedBox(height: 34),
          MdsWidthButton(
            text: '确定',
            onPressed: _submitForm,
          ),
          SizedBox(height: 34),
        ],
      ),
    );
  }
}
