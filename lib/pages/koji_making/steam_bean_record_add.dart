import 'package:dfmdsapp/utils/index.dart';

class SteamBeanRecordAddPage extends StatefulWidget {
  final arguments;
  SteamBeanRecordAddPage({Key key, this.arguments}) : super(key: key);

  @override
  _SteamBeanRecordAddPageState createState() => _SteamBeanRecordAddPageState();
}

class _SteamBeanRecordAddPageState extends State<SteamBeanRecordAddPage> {
  Map<String, dynamic> formMap = {'configDate': ''};

  @override
  void initState() {
    if (widget.arguments['data'] != null) {
      formMap = jsonDecode(jsonEncode(widget.arguments['data']));
    }
    super.initState();
  }

  _submitForm() {}

  Widget formWidget() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
      padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
      child: Column(
        children: <Widget>[
          InputWidget(
            label: '蒸球压力',
            suffix: 'Mpa',
            keyboardType: 'number',
            prop: formMap['consumeAmount'].toString(),
            requiredFlg: true,
            onChange: (val) {
              formMap['consumeAmount'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '蒸球号',
            suffix: 'Mpa',
            keyboardType: 'number',
            prop: formMap['consumeAmount'].toString(),
            requiredFlg: true,
            onChange: (val) {
              formMap['consumeAmount'] = val;
              setState(() {});
            },
          ),
          DataPickerWidget(
            label: '加汽开始时间',
            prop: formMap['configDate'],
            requiredFlg: true,
            onChange: (val) {
              formMap['configDate'] = val;
              setState(() {});
            },
          ),
          DataPickerWidget(
            label: '加汽结束时间',
            prop: formMap['configDate'],
            requiredFlg: true,
            onChange: (val) {
              formMap['configDate'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '气泡压力',
            suffix: 'Mpa',
            keyboardType: 'number',
            prop: formMap['consumeAmount'].toString(),
            onChange: (val) {
              formMap['consumeAmount'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '转动圈数',
            keyboardType: 'number',
            prop: formMap['consumeAmount'].toString(),
            onChange: (val) {
              formMap['consumeAmount'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '蒸煮时间',
            suffix: 'min',
            keyboardType: 'number',
            requiredFlg: true,
            prop: formMap['consumeAmount'].toString(),
            onChange: (val) {
              formMap['consumeAmount'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '保压时间',
            suffix: 'min',
            keyboardType: 'number',
            prop: formMap['consumeAmount'].toString(),
            onChange: (val) {
              formMap['consumeAmount'] = val;
              setState(() {});
            },
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
