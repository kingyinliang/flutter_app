import 'package:flutter/material.dart';
import 'package:dfmdsapp/components/appBar.dart';
import 'package:dfmdsapp/utils/pxunit.dart';

class NoNetPage extends StatefulWidget {
  NoNetPage({Key key}) : super(key: key);

  @override
  _NoNetPageState createState() => _NoNetPageState();
}

class _NoNetPageState extends State<NoNetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MdsAppBarWidget(titleData: '无网络'),
      backgroundColor: Color(0xFFF5F5F5),
      body: Container(
        width: pxUnit(350),
        height: pxUnit(315),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('lib/assets/images/notNet.png'),
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}
