import 'package:dfmdsapp/utils/index.dart';

class SteamBeanHardnessAddPage extends StatefulWidget {
  final arguments;
  SteamBeanHardnessAddPage({Key key, this.arguments}) : super(key: key);

  @override
  _SteamBeanHardnessAddPageState createState() =>
      _SteamBeanHardnessAddPageState();
}

class _SteamBeanHardnessAddPageState extends State<SteamBeanHardnessAddPage> {
  Map<String, dynamic> formMap = {
    'steamBallId': '',
    'steamBallNo': '',
    'steamBallName': '',
    'hardnessOne': '',
    'hardnessTwo': '',
    'hardnessThree': '',
    'hardnessFour': '',
    'hardnessFive': '',
    'hardnessSix': '',
    'hardnessSeven': '',
    'hardnessEight': '',
    'hardnessNine': '',
    'hardnessTen': '',
    'remark': '',
  };
  List steamBallNo = [];

  @override
  void initState() {
    if (widget.arguments['data'] != null) {
      formMap = jsonDecode(jsonEncode(widget.arguments['data']));
    }
    formMap['orderNo'] = widget.arguments['orderNo'];
    Future.delayed(
      Duration.zero,
      () => setState(() {
        _getSteamBallNo();
      }),
    );
    super.initState();
  }

  _getSteamBallNo() async {
    var workShop = await SharedUtil.instance.getStorage('workShopId');
    try {
      var res = await Common.holderDropDownQuery({
        'deptId': workShop,
        'holderType': ['026']
      });
      steamBallNo = res['data'];
      setState(() {});
    } catch (e) {}
  }

  _submitForm() async {
    if (formMap['id'] != null) {
      try {
        await KojiMaking.steamBeanHardnessUpdate(formMap);
        Navigator.pop(context, true);
      } catch (e) {}
    } else {
      try {
        await KojiMaking.steamBeanHardnessAdd(formMap);
        Navigator.pop(context, true);
      } catch (e) {}
    }
  }

  Widget formWidget() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
      padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
      child: Column(
        children: _getInput(),
      ),
    );
  }

  _getInput() {
    List listWidget = [];
    List keyArr = [
      'hardnessOne',
      'hardnessTwo',
      'hardnessThree',
      'hardnessFour',
      'hardnessFive',
      'hardnessSix',
      'hardnessSeven',
      'hardnessEight',
      'hardnessNine',
      'hardnessTen'
    ];
    listWidget = keyArr.asMap().keys.map((index) {
      return Container(
        child: InputWidget(
          label: '硬度${index + 1}',
          keyboardType: 'number',
          prop: formMap[keyArr[index]].toString(),
          requiredFlg: true,
          onChange: (val) {
            formMap[keyArr[index]] = val;
            setState(() {});
          },
        ),
      );
    }).toList();
    listWidget.add(Container(
      child: InputWidget(
        label: '备注',
        keyboardType: 'text',
        prop: formMap['remark'],
        onChange: (val) {
          formMap['remark'] = val;
          setState(() {});
        },
      ),
    ));
    listWidget.insert(
        0,
        Container(
          child: SelectWidget(
            label: '蒸球号',
            prop: formMap['steamBallNo'].toString(),
            requiredFlg: true,
            options: steamBallNo,
            optionsLabel: 'holderName',
            optionsval: 'holderNo',
            onChange: (val) {
              formMap['steamBallId'] = val['id'];
              formMap['steamBallNo'] = val['holderNo'];
              formMap['steamBallName'] = val['holderName'];
              setState(() {});
            },
          ),
        ));
    return listWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MdsAppBarWidget(titleData: formMap['id'] == null ? '新增' : '修改'),
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
