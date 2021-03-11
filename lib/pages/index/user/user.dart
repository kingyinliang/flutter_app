import 'dart:async';
import 'package:flutter/material.dart';

import 'package:dfmdsapp/components/dialog.dart';
import 'package:dfmdsapp/utils/storage.dart';
import 'package:dfmdsapp/api/api/index.dart';
import 'package:dfmdsapp/api/http/socket.dart';
import 'package:dfmdsapp/utils/path_provider.dart';
import 'package:dfmdsapp/assets/iconfont/icon_font.dart';
import 'package:dfmdsapp/utils/index.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with AutomaticKeepAliveClientMixin {
  Map userData = {'sex': 'M', 'realName': ''};
  String deptName;

  @override
  bool get wantKeepAlive => true;

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
    deptName = await SharedUtil.instance.getStorage('deptName');
    userData = await SharedUtil.instance.getMapStorage('userData');
  }

  _quit() async {
    try {
      await Common.quitLoginApi();
      WebSocketManager.dispos();
      Navigator.pop(context);
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    } catch (e) {}
  }

  _switchUser() {
    WebSocketManager.dispos();
    Navigator.pop(context);
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
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
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/user/userinfo');
                },
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
                            style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.fromLTRB(18, 0, 0, 0),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  UserItem(
                    icon: IconNames.icon_2_shanchu,
                    iconColor: ['#E86452', 'white'],
                    text: '清除缓存',
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return StorageDialog();
                        },
                      );
                    },
                  ),
                  UserItem(
                    icon: IconNames.icon_49_quanxianshezhi,
                    iconColor: ['white', '#F6BD16', '#F6BD16', 'white'],
                    text: '修改密码',
                    onTap: () {
                      Navigator.pushNamed(context, '/user/updatepasword');
                    },
                  ),
                  UserItem(
                    icon: IconNames.icon_52_ap_pguanli,
                    iconColor: [],
                    text: '系统版本',
                    onTap: () {
                      Navigator.pushNamed(context, '/user/versions');
                    },
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     Navigator.pushNamed(context, '/webview', arguments: {
                  //       'url':
                  //           'http://10.22.7.52:3000/v1/work/preview?id=123463'
                  //     });
                  //   },
                  //   child: Container(
                  //     padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  //     height: 40,
                  //     child: Text('webview'),
                  //   ),
                  // ),
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
            ),
          ],
        ),
      ),
    );
  }
}

class UserItem extends StatefulWidget {
  final IconNames icon;
  final String text;
  final Function onTap;
  final List<String> iconColor;
  UserItem({Key key, this.icon, this.text, this.onTap, this.iconColor})
      : super(key: key);

  @override
  _UserItemState createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 18, 0),
        height: 48,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFF999999), width: 0.25),
          ),
        ),
        child: Row(
          children: <Widget>[
            IconFont(widget.icon, size: 26, colors: widget.iconColor),
            // Icon(
            //   widget.icon,
            //   size: 26,
            //   color: widget.iconColor,
            // ),
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
      ),
    );
  }
}

class StorageDialog extends StatefulWidget {
  StorageDialog({Key key}) : super(key: key);

  @override
  _StorageDialogState createState() => _StorageDialogState();
}

class _StorageDialogState extends State<StorageDialog> {
  var size = '';
  _initState() async {
    size = await getFileStorageSize();
    setState(() {});
  }

  @override
  void initState() {
    Future.delayed(
        Duration.zero,
        () => setState(() {
              _initState();
            }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DiaLogContainer(
      success: () async {
        clearCache(() async {
          Navigator.of(context, rootNavigator: true).pop();
          await $successToast(context, msg: '清除成功，请重新登陆');
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.warning,
            color: Color(0xFFF94630),
            size: 38,
          ),
          SizedBox(height: 12),
          Text(
            '清理缓存',
            style: TextStyle(color: Color(0xFF333333), fontSize: 16),
          ),
          SizedBox(height: 12),
          Text(
            '系统缓存 ' + size,
            style: TextStyle(color: Color(0xFF666666), fontSize: 14),
          ),
          SizedBox(height: 4),
          Text(
            '确定清除缓存数据？',
            style: TextStyle(color: Color(0xFF666666), fontSize: 14),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
