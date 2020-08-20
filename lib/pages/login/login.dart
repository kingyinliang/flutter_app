import 'dart:convert';

import 'package:flutter/material.dart';
import '../../api/api/common.dart';
import '../../utils/storage.dart';
import '../../components/raisedButton.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _userName = new TextEditingController();
  var _password = new TextEditingController();
  var _rememberPaw = true;
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
    _userName.text = await getStorage('userName');
    _password.text = await getStorage('password');
  }

  _login() async {
    if (this._rememberPaw) {
      await saveStringStorage('userName', this._userName.text);
      await saveStringStorage('password', this._password.text);
    } else {
      await saveStringStorage('userName', '');
      await saveStringStorage('password', '');
    }
    var res;
    try {
      res = await Common.loginApi(
          {'userName': this._userName.text, 'password': this._password.text});
    } catch (e) {
      print(e);
    }

    print("res${res['code']}");
    Navigator.pop(context);
    Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    // Navigator.pushNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  SizedBox(height: 50),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 90,
                        child: Image.asset(
                          'lib/assets/images/loginLogo.png',
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 60),
                  Text("欢迎使用",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  Text("MDS制造管理系统",
                      style: TextStyle(color: Colors.white, fontSize: 32)),
                  SizedBox(height: 30),
                  InputContainer(
                    inputWidget: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        icon: Icon(Icons.people, color: Colors.white),
                        hintText: '账号/工号',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                      controller: _userName,
                    ),
                  ),
                  SizedBox(height: 10),
                  InputContainer(
                    inputWidget: TextField(
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        icon: Icon(Icons.people, color: Colors.white),
                        hintText: '密码',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                      controller: _password,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Checkbox(
                          activeColor: Color.fromRGBO(0, 0, 0, 0),
                          value: this._rememberPaw,
                          onChanged: (v) {
                            setState(() {
                              _rememberPaw = v;
                            });
                          }),
                      Text(
                        "记住密码",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )
                    ],
                  ),
                  SizedBox(height: 95),
                ],
              ),
            ),
            MdsWidthButton(
              text: '登录',
              onPressed: this._login,
            )
          ],
        ),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('lib/assets/images/loginBg.png'),
                fit: BoxFit.cover)),
      ),
    );
  }
}

class InputContainer extends StatefulWidget {
  final Widget inputWidget;
  InputContainer({Key key, this.inputWidget}) : super(key: key);

  @override
  _InputContainerState createState() => _InputContainerState();
}

class _InputContainerState extends State<InputContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 52.0,
      padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        color: Color(0x7F000000),
      ),
      child: widget.inputWidget,
    );
  }
}
