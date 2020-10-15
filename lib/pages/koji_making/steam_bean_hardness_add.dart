import 'package:dfmdsapp/utils/index.dart';

class SteamBeanHardnessAddPage extends StatefulWidget {
  final arguments;
  SteamBeanHardnessAddPage({Key key, this.arguments}) : super(key: key);

  @override
  _SteamBeanHardnessAddPageState createState() =>
      _SteamBeanHardnessAddPageState();
}

class _SteamBeanHardnessAddPageState extends State<SteamBeanHardnessAddPage> {
  Map<String, dynamic> formMap = {};

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
        children: _getInput(),
      ),
    );
  }

  _getInput() {
    List listWidget = [];
    List keyArr = [
      'consumeAmount1',
      'consumeAmount2',
      'consumeAmount3',
      'consumeAmount4',
      'consumeAmount5',
      'consumeAmount6',
      'consumeAmount7',
      'consumeAmount8',
      'consumeAmount9',
      'consumeAmount10'
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
