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
    'addKojiMans': '',
    'addKojiInfo': '',
    'addKojiStart': '',
    'addKojiEnd': '',
    'kojiDurationStandard': '',
    'addKojiTemp': '',
    'addKojiDuration': '',
    'addKojiDurationString': '0H',
    'changed': '',
    'changer': '',
  };

  @override
  void initState() {
    if (widget.arguments['data'] != null) {
      formMap = jsonDecode(jsonEncode(widget.arguments['data']));
      if (formMap['addKojiTemp'] == null) {
        formMap['addKojiTemp'] = '';
      }
      if (formMap['addKojiStart'] == null) {
        formMap['addKojiStart'] = '';
      }
      if (formMap['addKojiEnd'] == null) {
        formMap['addKojiEnd'] = '';
      }

      formMap['addKojiDurationString'] = '${formMap['addKojiDuration']}H';
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

    // 新增 data 时要带出时长标准
    try {
      var res = await KojiMaking.discInQuery(
          {"kojiOrderNo": widget.arguments['kojiOrderNo']});
      formMap['kojiDurationStandard'] = res['data']['kojiDurationStandard'];
      setState(() {});
    } catch (e) {}

    formMap['changed'] = formatDate(new DateTime.now(),
        ['yyyy', '-', 'mm', '-', 'dd', ' ', 'HH', ':', 'nn']);
    formMap['changer'] = userData['realName'];
  }

  // 获取时长
  _getDuration() {
    if (formMap['addKojiStart'] != '' && formMap['addKojiEnd'] != '') {
      int nowyear =
          int.parse(formMap['addKojiStart'].split(" ")[0].split('-')[0]);
      int nowmonth =
          int.parse(formMap['addKojiStart'].split(" ")[0].split('-')[1]);
      int nowday =
          int.parse(formMap['addKojiStart'].split(" ")[0].split('-')[2]);
      int nowhour =
          int.parse(formMap['addKojiStart'].split(" ")[1].split(':')[0]);
      int nowmin =
          int.parse(formMap['addKojiStart'].split(" ")[1].split(':')[1]);

      int oldyear =
          int.parse(formMap['addKojiEnd'].split(" ")[0].split('-')[0]);
      int oldmonth =
          int.parse(formMap['addKojiEnd'].split(" ")[0].split('-')[1]);
      int oldday = int.parse(formMap['addKojiEnd'].split(" ")[0].split('-')[2]);
      int oldhour =
          int.parse(formMap['addKojiEnd'].split(" ")[1].split(':')[0]);
      int oldmin = int.parse(formMap['addKojiEnd'].split(" ")[1].split(':')[1]);

      var now = new DateTime(nowyear, nowmonth, nowday, nowhour, nowmin);
      var old = new DateTime(oldyear, oldmonth, oldday, oldhour, oldmin);
      var difference = old.difference(now);

      formMap['addKojiDuration'] =
          formatNum((difference.inMinutes / 60), 2); // 时间差
      formMap['addKojiDurationString'] =
          '${formMap['addKojiDuration']}H'; // 时间差

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
//    if (formMap['addKojiInfo'] == null || formMap['addKojiInfo'] == '') {
//      EasyLoading.showError('请填写入曲情况');
//      return;
//    }
//    if (formMap['addKojiTemp'] == null || formMap['addKojiTemp'] == '') {
//      EasyLoading.showError('请填写入曲温度');
//      return;
//    }
//    if (formMap['addKojiStart'] == null || formMap['addKojiStart'] == '') {
//      EasyLoading.showError('请选择入曲开始时间');
//      return;
//    }
//    if (formMap['addKojiEnd'] == null || formMap['addKojiEnd'] == '') {
//      EasyLoading.showError('请选择入曲结束时间');
//      return;
//    }
    if (formMap['id'] != null) {
      try {
        await KojiMaking.discInSaveQuery(formMap);
        Navigator.pop(context, true);
      } catch (e) {}
    } else {
      try {
        formMap['orderNo'] = widget.arguments['orderNo'];
        formMap['kojiOrderNo'] = widget.arguments['kojiOrderNo'];
        await KojiMaking.discInSaveQuery(formMap);
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
        InputWidget(
          label: '入曲情况',
          keyboardType: 'text',
          prop: formMap['addKojiInfo'].toString(),
          requiredFlg: true,
          onChange: (val) {
            formMap['addKojiInfo'] = val;
            setState(() {});
          },
        ),
        OrgSelectUser(
          label: '入曲人',
          prop: formMap['addKojiMans'].split(','),
          requiredFlg: true,
          onChange: (List val) {
            formMap['addKojiMans'] = val.join(',');
            setState(() {});
          },
        ),
        InputWidget(
          label: '入曲温度',
          suffix: '℃',
          keyboardType: 'number',
          prop: formMap['addKojiTemp'].toString(),
          requiredFlg: true,
          onChange: (val) {
            formMap['addKojiTemp'] = val;
            setState(() {});
          },
        ),
        FormTextWidget(
          label: '入曲标准',
          prop: formMap['kojiDurationStandard'].toString(),
        ),
        DataPickerWidget(
          label: '入曲开始时间',
          prop: formMap['addKojiStart'].toString(),
          requiredFlg: true,
          onChange: (val) {
            formMap['addKojiStart'] = val;
            this._getDuration();
            setState(() {});
          },
        ),
        DataPickerWidget(
          label: '入曲结束时间',
          prop: formMap['addKojiEnd'].toString(),
          requiredFlg: true,
          onChange: (val) {
            formMap['addKojiEnd'] = val;
            this._getDuration();
            setState(() {});
          },
        ),
        FormTextWidget(
          label: '入曲时长',
          prop: formMap['addKojiDurationString'].toString(),
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
