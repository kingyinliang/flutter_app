import 'package:dfmdsapp/utils/index.dart';

class SteamTurnRecordAddPage extends StatefulWidget {
  final arguments;
  SteamTurnRecordAddPage({Key key, this.arguments}) : super(key: key);

  @override
  _SteamTurnRecordAddPageState createState() => _SteamTurnRecordAddPageState();
}

class _SteamTurnRecordAddPageState extends State<SteamTurnRecordAddPage> {
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
          FormTextWidget(
            label: '翻曲',
            requiredFlg: true,
            prop: '一翻',
          ),
          DataPickerWidget(
            label: '翻曲开始时间',
            prop: formMap['configDate'],
            requiredFlg: true,
            onChange: (val) {
              formMap['configDate'] = val;
              setState(() {});
            },
          ),
          DataPickerWidget(
            label: '翻曲结束时间',
            prop: formMap['configDate'],
            requiredFlg: true,
            onChange: (val) {
              formMap['configDate'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '外下温度',
            requiredFlg: true,
            keyboardType: 'number',
            prop: formMap['consumeAmount'].toString(),
            onChange: (val) {
              formMap['consumeAmount'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '翻曲加水量',
            keyboardType: 'number',
            prop: formMap['consumeAmount'].toString(),
            onChange: (val) {
              formMap['consumeAmount'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '翻曲人',
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
          Container(
            height: 10,
            color: Color(0xFFF5F5F5),
          ),
          FormTextWidget(
            label: '翻曲',
            requiredFlg: true,
            prop: '二翻',
          ),
          DataPickerWidget(
            label: '翻曲开始时间',
            prop: formMap['configDate'],
            requiredFlg: true,
            onChange: (val) {
              formMap['configDate'] = val;
              setState(() {});
            },
          ),
          DataPickerWidget(
            label: '翻曲结束时间',
            prop: formMap['configDate'],
            requiredFlg: true,
            onChange: (val) {
              formMap['configDate'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '外下温度',
            requiredFlg: true,
            keyboardType: 'number',
            prop: formMap['consumeAmount'].toString(),
            onChange: (val) {
              formMap['consumeAmount'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '翻曲加水量',
            keyboardType: 'number',
            prop: formMap['consumeAmount'].toString(),
            onChange: (val) {
              formMap['consumeAmount'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '翻曲人',
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
