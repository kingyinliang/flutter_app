import 'package:dfmdsapp/utils/index.dart';
import 'package:date_format/date_format.dart';

class SteamInStatusAddPage extends StatefulWidget {
  final arguments;
  SteamInStatusAddPage({Key key, this.arguments}) : super(key: key);

  @override
  _SteamInStatusAddPageState createState() => _SteamInStatusAddPageState();
}

class _SteamInStatusAddPageState extends State<SteamInStatusAddPage> {
  Map<String, dynamic> formMap = {
    'userList': [],
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

  _initState() async {
    Map userData = await SharedUtil.instance.getMapStorage('userData');

    formMap['changed'] = formatDate(new DateTime.now(),
        ['yyyy', '-', 'mm', '-', 'dd', ' ', 'HH', ':', 'nn']);
    formMap['changer'] = userData['realName'];
  }

  _submitForm() {}

  Widget formWidget() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
      padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
      child: Column(children: <Widget>[
        InputWidget(
          label: '入曲情况',
          keyboardType: 'number',
          prop: formMap['consumeAmount'].toString(),
          requiredFlg: true,
          onChange: (val) {
            formMap['consumeAmount'] = val;
            setState(() {});
          },
        ),
        OrgSelectUser(
          label: '入曲人',
          prop: formMap['userList'],
          requiredFlg: true,
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
          label: '入曲温度',
          suffix: '℃',
          keyboardType: 'number',
          prop: formMap['consumeAmount'].toString(),
          requiredFlg: true,
          onChange: (val) {
            formMap['consumeAmount'] = val;
            setState(() {});
          },
        ),
        DataPickerWidget(
          label: '入曲开始时间',
          prop: formMap['configDate'],
          requiredFlg: true,
          onChange: (val) {
            formMap['configDate'] = val;
            setState(() {});
          },
        ),
        DataPickerWidget(
          label: '入曲结束时间',
          prop: formMap['configDate'],
          requiredFlg: true,
          onChange: (val) {
            formMap['configDate'] = val;
            setState(() {});
          },
        ),
        FormTextWidget(
          label: '入曲时长',
          prop: formMap['time'].toString(),
        ),
        FormTextWidget(
          label: '操作人',
          prop: formMap['changer'].toString(),
        ),
        FormTextWidget(
          label: '操作时间',
          prop: formMap['changed'].toString(),
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
