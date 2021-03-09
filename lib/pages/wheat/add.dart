import 'package:dfmdsapp/utils/index.dart';

class WheatAddPage extends StatefulWidget {
  final arguments;

  WheatAddPage({Key key, this.arguments}) : super(key: key);

  @override
  _WheatAddPageState createState() => _WheatAddPageState();
}

class _WheatAddPageState extends State<WheatAddPage> {
  Map<String, dynamic> formMap = {
    'wheatDeviceVal': '',
    'wheatDeviceName': '',
    'flourDeviceVal': '',
    'flourDeviceName': '',
    'inPortBatch': '',
    'startWeight': '',
    'endWeight': '',
    'inPortWeight': '',
  };
  List orderList = [];
  List wheatDeviceList = [];
  List flourDeviceList = [];

  _submitForm() async {
    if (widget.arguments['tableIndex'] != null) {
      orderList[widget.arguments['orderIndex']]['table']
          [widget.arguments['tableIndex']] = formMap;
      await SharedUtil.instance.saveMapStorage('orderList', orderList);
      Navigator.pop(context, true);
    } else {
      orderList[widget.arguments['orderIndex']]['table'].add(formMap);
      await SharedUtil.instance.saveMapStorage('orderList', orderList);
      Navigator.pop(context, true);
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
            prop: formMap['wheatDeviceVal'].toString(),
            requiredFlg: true,
            options: wheatDeviceList,
            optionsLabel: 'holderName',
            optionsval: 'holderId',
            onChange: (val) {
              formMap['wheatDeviceVal'] = val['holderId'];
              setState(() {});
            },
          ),
          SelectWidget(
            label: '粮仓号',
            prop: formMap['flourDeviceVal'].toString(),
            requiredFlg: true,
            options: flourDeviceList,
            optionsLabel: 'holderName',
            optionsval: 'holderId',
            onChange: (val) {
              formMap['flourDeviceVal'] = val['holderId'];
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
    wheatDeviceList =
        await SharedUtil.instance.getMapStorage('wheatDeviceList');
    flourDeviceList =
        await SharedUtil.instance.getMapStorage('flourDeviceList');
    orderList = await SharedUtil.instance.getMapStorage('orderList');
    if (widget.arguments['tableIndex'] != null) {
      formMap = jsonDecode(jsonEncode(orderList[widget.arguments['orderIndex']]
          ['table'][widget.arguments['tableIndex']]));
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
      appBar:
          MdsAppBarWidget(titleData: formMap['id'] == null ? '入库新增' : '入库修改'),
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
