import 'package:flutter/material.dart';
import 'package:dfmdsapp/components/appBar.dart';
import 'package:dfmdsapp/components/form.dart';
import 'package:package_info/package_info.dart';
import 'package:dfmdsapp/utils/version_update.dart';

class VersionsPage extends StatefulWidget {
  final arguments;
  VersionsPage({Key key, this.arguments}) : super(key: key);

  @override
  _VersionsPageState createState() => _VersionsPageState();
}

class _VersionsPageState extends State<VersionsPage> {
  String version = '';

  _initState() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
  }

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () => setState(() {
        _initState();
      }),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MdsAppBarWidget(titleData: '系统版本'),
      backgroundColor: Color(0xFFF5F5F5),
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 50),
              Container(
                width: 170,
                child: Image.asset(
                  'lib/assets/images/loginLogo.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '版本 V$version',
                style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
              ),
            ],
          ),
          SizedBox(height: 40),
          Container(
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
            padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
            child: InkWell(
              onTap: () {
                varsionUpdateInit(context, flag: true);
              },
              child: FormItem(
                label: '检查新版本',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: Color(0xFFCCCCCC),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
