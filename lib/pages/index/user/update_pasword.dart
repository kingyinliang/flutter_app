import 'package:flutter/material.dart';
import 'package:dfmdsapp/components/appBar.dart';
import 'package:dfmdsapp/components/form.dart';
import 'package:dfmdsapp/utils/storage.dart';
import 'package:dfmdsapp/components/raisedButton.dart';
import 'package:dfmdsapp/utils/index.dart';
import 'package:dfmdsapp/api/api/index.dart';

class UpdatePaswordPage extends StatefulWidget {
  final arguments;
  UpdatePaswordPage({Key key, this.arguments}) : super(key: key);

  @override
  _UpdatePaswordPageState createState() => _UpdatePaswordPageState();
}

class _UpdatePaswordPageState extends State<UpdatePaswordPage> {
  Map userData = {'sex': 'M', 'realName': ''};
  Map formMap = {'password': '', 'newPassword': '', 'conPassword': ''};
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () => setState(() {
        _initState();
      }),
    );
  }

  _submitForm() async {
    RegExp exp = new RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^]{8,12}$");
    if (formMap['password'].length == 0) {
      $warningToast(context, msg: '请输入原始密码');
      return;
    }
    if (exp.hasMatch(formMap['newPassword']) == false) {
      $warningToast(context, msg: '请输入8-12位数字大小写字母组合');
      return;
    }
    if (formMap['newPassword'] != formMap['conPassword']) {
      $warningToast(context, msg: '两次输入密码不一致');
      return;
    }
    try {
      await Common.updatePasswordApi(formMap);
      $successToast(context, msg: '密码修改成功');
    } catch (e) {}
  }

  _initState() async {
    userData = await SharedUtil.instance.getMapStorage('userData');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MdsAppBarWidget(titleData: '修改密码'),
      backgroundColor: Color(0xFFF5F5F5),
      body: ListView(
        children: <Widget>[
          Container(
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
            padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
            child: Column(
              children: <Widget>[
                FormTextWidget(
                  label: '账号',
                  prop: userData['workNum'].toString(),
                ),
                FormTextWidget(
                  label: '姓名',
                  prop: userData['realName'].toString(),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
            padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
            child: Column(
              children: <Widget>[
                InputWidget(
                  label: '原始密码',
                  requiredFlg: true,
                  eye: true,
                  prop: formMap['password'].toString(),
                  onChange: (val) {
                    formMap['password'] = val;
                    setState(() {});
                  },
                ),
                InputWidget(
                  label: '新密码',
                  requiredFlg: true,
                  eye: true,
                  prop: formMap['newPassword'].toString(),
                  onChange: (val) {
                    formMap['newPassword'] = val;
                    setState(() {});
                  },
                ),
                InputWidget(
                  label: '确认密码',
                  requiredFlg: true,
                  eye: true,
                  prop: formMap['conPassword'].toString(),
                  onChange: (val) {
                    formMap['conPassword'] = val;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 50),
          MdsWidthButton(
            text: '确定',
            onPressed: _submitForm,
          )
        ],
      ),
    );
  }
}
