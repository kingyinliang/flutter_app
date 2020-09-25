import 'package:flutter/material.dart';
import 'package:dfmdsapp/components/appBar.dart';
import 'package:dfmdsapp/components/form.dart';
import 'package:dfmdsapp/utils/storage.dart';

class UserInfoPage extends StatefulWidget {
  final arguments;
  UserInfoPage({Key key, this.arguments}) : super(key: key);

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  Map userData = {'sex': 'M', 'realName': ''};
  String deptName = '';
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

  _initState() async {
    deptName = await SharedUtil.instance.getStorage('deptName');
    userData = await SharedUtil.instance.getMapStorage('userData');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MdsAppBarWidget(titleData: '个人信息'),
      backgroundColor: Color(0xFFF5F5F5),
      body: ListView(
        children: <Widget>[
          Container(
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
            padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
            child: Column(
              children: <Widget>[
                FormItem(
                  label: '头像',
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: this.userData['sex'] == 'F'
                                ? AssetImage('lib/assets/images/feman.png')
                                : AssetImage('lib/assets/images/man.png'),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                        color: Color(0xFFCCCCCC),
                      )
                    ],
                  ),
                ),
                FormTextWidget(
                  label: '账号',
                  prop: userData['workNum'].toString(),
                ),
                FormTextWidget(
                  label: '姓名',
                  prop: userData['realName'].toString(),
                ),
                FormTextWidget(
                  label: '部门',
                  prop: deptName,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
