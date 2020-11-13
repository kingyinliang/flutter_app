import 'package:dfmdsapp/utils/index.dart';
import 'package:date_format/date_format.dart';

class SteamOutRecordAddPage extends StatefulWidget {
  final arguments;
  SteamOutRecordAddPage({Key key, this.arguments}) : super(key: key);

  @override
  _SteamOutRecordAddPageState createState() => _SteamOutRecordAddPageState();
}

class _SteamOutRecordAddPageState extends State<SteamOutRecordAddPage> {
  Map<String, dynamic> formMap = {
    'kojiOrderNoe': '',
    'orderNo': '',
    'outKojiDuration': 0,
    'outKojiDurationString': '0 H',
    'outKojiEnd': '',
    'outKojiMans': '',
    'outKojiTemp': 0,
    'outKojiStart': '',
    // 'status': '',
    'changed': '',
    'changer': '',
  };

  @override
  void initState() {
    if (widget.arguments['data'] != null) {
      formMap = jsonDecode(jsonEncode(widget.arguments['data']));
      if (formMap['outKojiEnd'] == null) {
        formMap['outKojiEnd'] = '';
      }
      if (formMap['outKojiStart'] == null) {
        formMap['outKojiStart'] = '';
      }
      formMap['outKojiDurationString'] = '${formMap['outKojiDuration']} H';
      formMap['orderNo'] = widget.arguments['orderNo'];
      formMap['kojiOrderNo'] = widget.arguments['kojiOrderNo'];
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

  // 获取时长
  _getDuration() {
    if (formMap['outKojiStart'] != '' && formMap['outKojiEnd'] != '') {
      int nowyear =
          int.parse(formMap['outKojiStart'].split(" ")[0].split('-')[0]);
      int nowmonth =
          int.parse(formMap['outKojiStart'].split(" ")[0].split('-')[1]);
      int nowday =
          int.parse(formMap['outKojiStart'].split(" ")[0].split('-')[2]);
      int nowhour =
          int.parse(formMap['outKojiStart'].split(" ")[1].split(':')[0]);
      int nowmin =
          int.parse(formMap['outKojiStart'].split(" ")[1].split(':')[1]);

      int oldyear =
          int.parse(formMap['outKojiEnd'].split(" ")[0].split('-')[0]);
      int oldmonth =
          int.parse(formMap['outKojiEnd'].split(" ")[0].split('-')[1]);
      int oldday = int.parse(formMap['outKojiEnd'].split(" ")[0].split('-')[2]);
      int oldhour =
          int.parse(formMap['outKojiEnd'].split(" ")[1].split(':')[0]);
      int oldmin = int.parse(formMap['outKojiEnd'].split(" ")[1].split(':')[1]);

      var now = new DateTime(nowyear, nowmonth, nowday, nowhour, nowmin);
      var old = new DateTime(oldyear, oldmonth, oldday, oldhour, oldmin);
      var difference = old.difference(now);

      formMap['outKojiDuration'] =
          formatNum((difference.inMinutes / 60), 2); // 时间差
      formMap['outKojiDurationString'] =
          '${formMap['outKojiDuration']} H'; // 时间差

    }
  }

  formatNum(double num, int postion) {
    if ((num.toString().length - num.toString().lastIndexOf(".") - 1) <
        postion) {
      //小数点后有几位小数
      return num.toStringAsFixed(postion)
          .substring(0, num.toString().lastIndexOf(".") + postion + 1)
          .toString();
    } else {
      return num.toString()
          .substring(0, num.toString().lastIndexOf(".") + postion + 1)
          .toString();
    }
  }

  String listToString(list) {
    if (list == null) {
      return null;
    }
    String result;
    list.forEach((string) =>
        {if (result == null) result = string else result = '$result，$string'});
    return result.toString();
  }

  _submitForm() async {
    if (formMap['outKojiStart'] == null || formMap['outKojiStart'] == '') {
      errorToast(msg: '请选择出曲开始时间');
      return;
    }
    if (formMap['outKojiEnd'] == null || formMap['outKojiEnd'] == '') {
      errorToast(msg: '请选择出曲结束时间');
      return;
    }
    if (formMap['outKojiMans'] == null || formMap['outKojiMans'] == '') {
      errorToast(msg: '请选择出曲操作人');
      return;
    }
    if (formMap['outKojiTemp'] == null || formMap['outKojiTemp'] == '') {
      errorToast(msg: '请输入出曲温度');
      return;
    }

    formMap['orderNo'] = widget.arguments['orderNo'];
    formMap['kojiOrderNo'] = widget.arguments['kojiOrderNo'];
    if (formMap['id'] != null) {
      try {
        await KojiMaking.steamDiscOutSave(formMap);
        Navigator.pop(context, true);
      } catch (e) {}
    } else {
      try {
        await KojiMaking.steamDiscOutSave(formMap);
        Navigator.pop(context, true);
      } catch (e) {}
    }
  }

  Widget formWidget() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
      padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
      child: Column(children: <Widget>[
        DataPickerWidget(
          label: '出曲开始时间',
          prop: formMap['outKojiStart'].toString(),
          requiredFlg: true,
          onChange: (val) {
            formMap['outKojiStart'] = val;
            this._getDuration();
            setState(() {});
          },
        ),
        DataPickerWidget(
          label: '出曲结束时间',
          prop: formMap['outKojiEnd'].toString(),
          requiredFlg: true,
          onChange: (val) {
            formMap['outKojiEnd'] = val;
            this._getDuration();
            setState(() {});
          },
        ),
        FormTextWidget(
          label: '出曲时长',
          prop: formMap['outKojiDurationString'].toString(),
        ),
        OrgSelectUser(
          label: '出曲操作人',
          prop: formMap['outKojiMans'].split(','),
          requiredFlg: true,
          onChange: (List val) {
            formMap['outKojiMans'] = val.join(',');
            setState(() {});
          },
        ),
        InputWidget(
          label: '出曲温度',
          suffix: '℃',
          keyboardType: 'number',
          prop: formMap['outKojiTemp'].toString(),
          requiredFlg: true,
          onChange: (val) {
            formMap['outKojiTemp'] = val;
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
