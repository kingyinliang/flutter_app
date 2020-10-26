import 'package:dfmdsapp/utils/index.dart';

class SteamLookRecordAddPage extends StatefulWidget {
  final arguments;
  SteamLookRecordAddPage({Key key, this.arguments}) : super(key: key);

  @override
  _SteamLookRecordAddPageState createState() => _SteamLookRecordAddPageState();
}

class _SteamLookRecordAddPageState extends State<SteamLookRecordAddPage> {
  Map<String, dynamic> formMap = {
    'configDate': '',
    'changed': '',
    'changer': '',
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
    super.initState();
  }

  _initState() async {}

  _submitForm() {}

  Widget formWidget() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
      padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
      child: Column(children: <Widget>[
        InputWidget(
          label: '看曲时间',
          keyboardType: 'number',
          prop: formMap['consumeAmount'].toString(),
          requiredFlg: true,
          onChange: (val) {
            formMap['consumeAmount'] = val;
            setState(() {});
          },
        ),
        Container(
          height: 20,
          color: Color(0xFFF5F5F5),
          child: Text(
            '温度控制',
            style: TextStyle(color: Color(0xFF333333), fontSize: 17),
          ),
        ),
        InputWidget(
          label: '入曲人',
          keyboardType: 'number',
          prop: formMap['consumeAmount'].toString(),
          requiredFlg: true,
          onChange: (val) {
            formMap['consumeAmount'] = val;
            setState(() {});
          },
        ),
        InputWidget(
          label: '实际风温',
          prop: formMap['consumeAmount'].toString(),
          requiredFlg: true,
          onChange: (val) {
            formMap['consumeAmount'] = val;
            setState(() {});
          },
        ),
        InputWidget(
          label: '设定风温',
          prop: formMap['consumeAmount'].toString(),
          onChange: (val) {
            formMap['consumeAmount'] = val;
            setState(() {});
          },
        ),
        InputWidget(
          label: '下室温度',
          requiredFlg: true,
          prop: formMap['consumeAmount'].toString(),
          onChange: (val) {
            formMap['consumeAmount'] = val;
            setState(() {});
          },
        ),
        InputWidget(
          label: '品温',
          requiredFlg: true,
          prop: formMap['consumeAmount'].toString(),
          onChange: (val) {
            formMap['consumeAmount'] = val;
            setState(() {});
          },
        ),
        InputWidget(
          label: '设定品温',
          prop: formMap['consumeAmount'].toString(),
          onChange: (val) {
            formMap['consumeAmount'] = val;
            setState(() {});
          },
        ),
        Container(
          height: 20,
          color: Color(0xFFF5F5F5),
          child: Text(
            '探头温度',
            style: TextStyle(color: Color(0xFF333333), fontSize: 17),
          ),
        ),
        InputWidget(
          label: '外上温度',
          requiredFlg: true,
          prop: formMap['consumeAmount'].toString(),
          onChange: (val) {
            formMap['consumeAmount'] = val;
            setState(() {});
          },
        ),
        InputWidget(
          label: '外中温度',
          requiredFlg: true,
          prop: formMap['consumeAmount'].toString(),
          onChange: (val) {
            formMap['consumeAmount'] = val;
            setState(() {});
          },
        ),
        InputWidget(
          label: '外下温度',
          requiredFlg: true,
          prop: formMap['consumeAmount'].toString(),
          onChange: (val) {
            formMap['consumeAmount'] = val;
            setState(() {});
          },
        ),
        InputWidget(
          label: '内上温度',
          prop: formMap['consumeAmount'].toString(),
          onChange: (val) {
            formMap['consumeAmount'] = val;
            setState(() {});
          },
        ),
        InputWidget(
          label: '内中温度',
          prop: formMap['consumeAmount'].toString(),
          onChange: (val) {
            formMap['consumeAmount'] = val;
            setState(() {});
          },
        ),
        InputWidget(
          label: '内下温度',
          prop: formMap['consumeAmount'].toString(),
          onChange: (val) {
            formMap['consumeAmount'] = val;
            setState(() {});
          },
        ),
        Container(
          height: 20,
          color: Color(0xFFF5F5F5),
          child: Text(
            '设备控制',
            style: TextStyle(color: Color(0xFF333333), fontSize: 17),
          ),
        ),
        InputWidget(
          label: '风门开度',
          prop: formMap['consumeAmount'].toString(),
          onChange: (val) {
            formMap['consumeAmount'] = val;
            setState(() {});
          },
        ),
        InputWidget(
          label: '强排设备',
          prop: formMap['consumeAmount'].toString(),
          onChange: (val) {
            formMap['consumeAmount'] = val;
            setState(() {});
          },
        ),
        InputWidget(
          label: '换热设备',
          requiredFlg: true,
          prop: formMap['consumeAmount'].toString(),
          onChange: (val) {
            formMap['consumeAmount'] = val;
            setState(() {});
          },
        ),
        InputWidget(
          label: '风速',
          requiredFlg: true,
          prop: formMap['consumeAmount'].toString(),
          onChange: (val) {
            formMap['consumeAmount'] = val;
            setState(() {});
          },
        ),
        Container(
          height: 20,
          color: Color(0xFFF5F5F5),
          child: Text(
            '测量温度',
            style: TextStyle(color: Color(0xFF333333), fontSize: 17),
          ),
        ),
        InputWidget(
          label: '测量温度1',
          requiredFlg: true,
          prop: formMap['consumeAmount'].toString(),
          onChange: (val) {
            formMap['consumeAmount'] = val;
            setState(() {});
          },
        ),
        InputWidget(
          label: '测量温度2',
          requiredFlg: true,
          prop: formMap['consumeAmount'].toString(),
          onChange: (val) {
            formMap['consumeAmount'] = val;
            setState(() {});
          },
        ),
        InputWidget(
          label: '备注',
          prop: formMap['consumeAmount'].toString(),
          onChange: (val) {
            formMap['consumeAmount'] = val;
            setState(() {});
          },
        ),
      ]),
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
