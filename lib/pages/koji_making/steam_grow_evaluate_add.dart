import 'package:dfmdsapp/utils/index.dart';

class SteamGrowEvaluateAddPage extends StatefulWidget {
  final arguments;
  SteamGrowEvaluateAddPage({Key key, this.arguments}) : super(key: key);

  @override
  _SteamGrowEvaluateAddPageState createState() =>
      _SteamGrowEvaluateAddPageState();
}

class _SteamGrowEvaluateAddPageState extends State<SteamGrowEvaluateAddPage> {
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
            label: '评价阶段',
            keyboardType: 'number',
            prop: formMap['consumeAmount'].toString(),
            requiredFlg: true,
            onChange: (val) {
              formMap['consumeAmount'] = val;
              setState(() {});
            },
          ),
          DataPickerWidget(
            label: '记录时间',
            prop: formMap['configDate'],
            requiredFlg: true,
            onChange: (val) {
              formMap['configDate'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '生长情况',
            requiredFlg: true,
            prop: formMap['consumeAmount'].toString(),
            onChange: (val) {
              formMap['consumeAmount'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '异常描述',
            prop: formMap['consumeAmount'].toString(),
            onChange: (val) {
              formMap['consumeAmount'] = val;
              setState(() {});
            },
          ),
          InputWidget(
            label: '记录人',
            requiredFlg: true,
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
