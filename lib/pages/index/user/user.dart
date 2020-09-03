import 'package:flutter/material.dart';
import '../../../utils/storage.dart';
import '../../../api/api/index.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Map userData = {'sex': 'M', 'realName': ''};
  String deptName;
  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration.zero,
        () => setState(() {
              _initState();
            }));
  }

  _initState() async {
    deptName = await getStorage('deptName');
    userData = await getMapStorage('userData');
  }

  _quit() async {
    try {
      await Common.quitLoginApi();
      Navigator.pop(context);
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    } catch (e) {}
  }

  _switchUser() {
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: 172,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF749BFF),
                  Color(0xFF1664FF),
                ],
                stops: [0.2, 1],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: <Widget>[
                SizedBox(width: 20),
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: this.userData['sex'] == 'F'
                          ? AssetImage('lib/assets/images/feman.png')
                          : AssetImage('lib/assets/images/man.png'),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(this.userData['realName'] ?? '',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600)),
                    SizedBox(height: 6),
                    Text(this.deptName ?? '',
                        style: TextStyle(color: Colors.white, fontSize: 15)),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.fromLTRB(18, 0, 0, 0),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                UserItem(
                  icon: IconData(0xe63d, fontFamily: 'MdsIcon'),
                  iconColor: Color(0xFFA0DD94),
                  text: '信息安全/隐私政策',
                ),
                UserItem(
                  icon: IconData(0xe674, fontFamily: 'MdsIcon'),
                  iconColor: Color(0xFFE86452),
                  text: '清除缓存',
                ),
                UserItem(
                  icon: IconData(0xe6ba, fontFamily: 'MdsIcon'),
                  iconColor: Color(0xFFF6BD16),
                  text: '修改密码',
                ),
                UserItem(
                  icon: IconData(0xe6ac, fontFamily: 'MdsIcon'),
                  iconColor: Color(0xFF5B8FF9),
                  text: '系统版本',
                ),
              ],
            ),
          ),
          SizedBox(height: 50),
          Padding(
            padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
            child: Container(
              height: 49,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 2.0),
                    color: Color(0x0D000000),
                    blurRadius: 4.0,
                    spreadRadius: 0,
                  )
                ],
              ),
              child: RaisedButton(
                color: Colors.white,
                elevation: 0,
                textColor: Color(0xFF333333),
                child: Text(
                  '切换用户',
                  style: TextStyle(fontSize: 18.0),
                ),
                onPressed: _switchUser,
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
            child: Container(
              height: 49,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 2.0),
                    color: Color(0x0D000000),
                    blurRadius: 4.0,
                    spreadRadius: 0,
                  )
                ],
              ),
              child: RaisedButton(
                color: Colors.white,
                elevation: 0,
                textColor: Color(0xFF333333),
                child: Text(
                  '退出登录',
                  style: TextStyle(fontSize: 18.0),
                ),
                onPressed: _quit,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class UserItem extends StatefulWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  UserItem({Key key, this.icon, this.text, this.iconColor}) : super(key: key);

  @override
  _UserItemState createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 18, 0),
      height: 48,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFF999999), width: 0.25),
        ),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            widget.icon,
            size: 26,
            color: widget.iconColor,
          ),
          SizedBox(width: 17),
          Expanded(
            flex: 1,
            child: Text(
              widget.text ?? '',
              style: TextStyle(color: Color(0xFF333333), fontSize: 17),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 15,
            color: Color(0xFFCCCCCC),
          )
        ],
      ),
    );
  }
}
