import 'package:dfmdsapp/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../api/api/common.dart';
import '../../utils/storage.dart';
import '../../components/raisedButton.dart';
import '../../api/http/dio.dart';
import 'package:dfmdsapp/utils/version_update.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _userName = new TextEditingController();
  var _password = new TextEditingController();
  var _rememberPaw = true;
  var _eye = true;
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
    _userName.text = await SharedUtil.instance.getStorage('userName');
    _password.text = await SharedUtil.instance.getStorage('password');
    varsionUpdateInit(context);
  }

  _login() async {
    if (_userName.text.length != 8) {
      infoToast(msg: '请输出长度为 8 个字符账号/工号');
      return;
    }
    if (_password.text.length > 12 || _password.text.length < 8) {
      infoToast(msg: '请输出长度在 8 到 12 个字符的密码');
      return;
    }
    if (this._rememberPaw) {
      await SharedUtil.instance
          .saveStringStorage('userName', this._userName.text);
      await SharedUtil.instance
          .saveStringStorage('password', this._password.text);
    } else {
      await SharedUtil.instance.saveStringStorage('userName', '');
      await SharedUtil.instance.saveStringStorage('password', '');
    }
    try {
      var res = await Common.loginApi({
        'userName': this._userName.text,
        'password': this._password.text,
        'terminal': 'APP'
      });
      String deptName = '';
      res['data']['sysDept'].forEach((element) {
        if (element['deptName'] != '欣和总部') {
          deptName = deptName + element['deptName'] + '/';
        }
        if (element['deptType'] == 'FACTORY') {
          SharedUtil.instance.saveStringStorage('factory', element['deptName']);
          SharedUtil.instance.saveStringStorage('factoryId', element['id']);
        }
      });
      await SharedUtil.instance
          .saveStringStorage('token', res['data']['token']);
      await SharedUtil.instance
          .saveStringStorage('loginUserId', res['data']['id']);
      await SharedUtil.instance.saveStringStorage('deptName', deptName);
      await SharedUtil.instance.saveMapStorage('userData', res['data']);
      await HttpManager.getInstance().updateToken();
      Navigator.pop(context);
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    } catch (e) {}
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
                  TextField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      fillColor: Color(0x7F000000),
                      filled: true,
                      prefixIcon: Icon(Icons.person, color: Colors.white),
                      suffixIcon: _userName.text != '' && _userName.text != null
                          ? InkWell(
                              child: Icon(Icons.close, color: Colors.white),
                              onTap: () => {
                                setState(() {
                                  _userName.text = '';
                                })
                              },
                            )
                          : null,
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: '账号/工号',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    controller: _userName,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  SizedBox(height: 10),
                  TextField(
                    obscureText: _eye,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      fillColor: Color(0x7F000000),
                      filled: true,
                      prefixIcon: Icon(Icons.lock, color: Colors.white),
                      suffixIcon: _password.text != '' && _password.text != null
                          ? InkWell(
                              child: Icon(
                                  _eye
                                      ? Icons.visibility_off
                                      : Icons.remove_red_eye,
                                  color: Colors.white),
                              onTap: () => {
                                setState(() {
                                  _eye = !_eye;
                                })
                              },
                            )
                          : null,
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: '密码',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    controller: _password,
                    onChanged: (value) {
                      setState(() {});
                    },
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
