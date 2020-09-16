import 'package:flutter/material.dart';
import 'package:dfmdsapp/components/appBar.dart';
import 'package:dfmdsapp/components/form.dart';
import 'package:dfmdsapp/utils/storage.dart';
import 'package:dfmdsapp/components/raisedButton.dart';
import 'package:dfmdsapp/utils/pxunit.dart' show pxUnit;

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

  _submitForm() {}

  _initState() async {
    userData = await getMapStorage('userData');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MdsAppBarWidget(titleData: '修改密码'),
        backgroundColor: Color(0xFFF5F5F5),
        body: Stack(
          children: <Widget>[
            Positioned(
              bottom: 20,
              width: pxUnit(375),
              child: MdsWidthButton(
                text: '确定',
                onPressed: _submitForm,
              ),
            ),
            ListView(
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
                        prop: formMap['password'].toString(),
                        onChange: (val) {
                          formMap['password'] = val;
                          setState(() {});
                        },
                      ),
                      InputWidget(
                        label: '新密码',
                        requiredFlg: true,
                        prop: formMap['newPassword'].toString(),
                        onChange: (val) {
                          formMap['newPassword'] = val;
                          setState(() {});
                        },
                      ),
                      InputWidget(
                        label: '确认密码',
                        requiredFlg: true,
                        prop: formMap['conPassword'].toString(),
                        onChange: (val) {
                          formMap['conPassword'] = val;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
