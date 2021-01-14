import 'package:dfmdsapp/utils/index.dart';
import 'package:date_format/date_format.dart';

class SteamHybridControlAddPage extends StatefulWidget {
  final arguments;
  SteamHybridControlAddPage({Key key, this.arguments}) : super(key: key);

  @override
  _SteamHybridControlAddPageState createState() =>
      _SteamHybridControlAddPageState();
}

class _SteamHybridControlAddPageState extends State<SteamHybridControlAddPage> {
  Map<String, dynamic> formMap = {
    'flourWindTemp': '',
    'beanWindTempOne': '',
    'beanWindTempTwo': '',
    'mixtureTempOne': '',
    'mixtureTempTwo': '',
    'beanWindFrequency': '',
    'mixtrueEnd': '',
    'mixtureStart': '',
  };

  @override
  void initState() {
    if (widget.arguments['data'] != null) {
      formMap = jsonDecode(jsonEncode(widget.arguments['data']));
    } else {
      Future.delayed(
        Duration.zero,
        () => setState(() {
          _initState();
        }),
      );
    }
    formMap['orderNo'] = widget.arguments['orderNo'];
    formMap['kojiOrderNo'] = widget.arguments['kojiOrderNo'];
    super.initState();
  }

  _initState() async {
    Map userData = await SharedUtil.instance.getMapStorage('userData');

    formMap['changed'] = formatDate(new DateTime.now(),
        ['yyyy', '-', 'mm', '-', 'dd', ' ', 'HH', ':', 'nn']);
    formMap['changer'] = userData['realName'];
  }

  _submitForm() async {
    if (formMap['id'] != null) {
      try {
        await KojiMaking.steamHybridControlUpdate(formMap);
        Navigator.pop(context, true);
      } catch (e) {}
    } else {
      try {
        await KojiMaking.steamHybridControlAdd(formMap);
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
        children: <Widget>[
          InputWidget(
            label: '蒸面风冷温度',
            requiredFlg: true,
            suffix: '℃',
            keyboardType: 'number',
            prop: formMap['flourWindTemp'].toString(),
            onChange: (val) {
              formMap['flourWindTemp'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '大豆风冷温度1',
            suffix: '℃',
            keyboardType: 'number',
            prop: formMap['beanWindTempOne'].toString(),
            requiredFlg: true,
            onChange: (val) {
              formMap['beanWindTempOne'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '大豆风冷温度2',
            suffix: '℃',
            keyboardType: 'number',
            prop: formMap['beanWindTempTwo'].toString(),
            onChange: (val) {
              formMap['beanWindTempTwo'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '混合料温度1',
            suffix: '℃',
            keyboardType: 'number',
            prop: formMap['mixtureTempOne'].toString(),
            requiredFlg: true,
            onChange: (val) {
              formMap['mixtureTempOne'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '混合料温度2',
            suffix: '℃',
            keyboardType: 'number',
            prop: formMap['mixtureTempTwo'].toString(),
            onChange: (val) {
              formMap['mixtureTempTwo'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '大豆风冷变频',
            suffix: 'Hz',
            keyboardType: 'number',
            prop: formMap['beanWindFrequency'].toString(),
            requiredFlg: true,
            onChange: (val) {
              formMap['beanWindFrequency'] = val;
              setState(() {});
            },
          ),
          DataPickerWidget(
            label: '混合开始时间',
            prop: formMap['mixtureStart'],
            requiredFlg: true,
            onChange: (val) {
              formMap['mixtureStart'] = val;
              setState(() {});
            },
          ),
          DataPickerWidget(
            label: '混合结束时间',
            prop: formMap['mixtrueEnd'],
            requiredFlg: true,
            onChange: (val) {
              formMap['mixtrueEnd'] = val;
              setState(() {});
            },
          ),
          FormTextWidget(
            label: '操作人',
            prop: formMap['changer'].toString(),
          ),
          FormTextWidget(
            label: '操作时间',
            prop: formMap['changed'].toString(),
          ),
        ],
      ),
    );
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
