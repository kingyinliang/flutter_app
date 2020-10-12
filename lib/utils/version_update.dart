import 'dart:isolate';
import 'dart:ui';

import 'package:dfmdsapp/utils/pxunit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:install_plugin/install_plugin.dart';

varsionUpdateInit(BuildContext context) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;
  String newVersion = '1.0.1';
  if (version != newVersion) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return VersionUpdateDialog(
            varsion: newVersion,
            url:
                'https://s3-033-shinho-mds-uat-bjs.s3.cn-north-1.amazonaws.com.cn/apk/app-release.apk');
      },
    );
  }
}

class VersionUpdateDialog extends StatefulWidget {
  final String url;
  final String varsion;
  VersionUpdateDialog({Key key, this.url, this.varsion}) : super(key: key);

  @override
  _VersionUpdateDialogState createState() => _VersionUpdateDialogState();
}

class _VersionUpdateDialogState extends State<VersionUpdateDialog> {
  var progress;
  var flutterDown;
  var taskId;
  ReceivePort _port = ReceivePort();

  _download() async {
    if (await Permission.storage.request().isGranted) {
      final path = (await getExternalStorageDirectory()).path.toString();

      //发起请求
      taskId = await FlutterDownloader.enqueue(
          url: widget.url,
          fileName: 'dfmds-${widget.varsion}.apk',
          savedDir: path,
          showNotification: true,
          openFileFromNotification: true);
    }
  }

  static void downloadCallback(id, status, progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  /// 安装
  Future<Null> _installApk() async {
    try {
      final path = (await getExternalStorageDirectory()).path.toString();
      InstallPlugin.installApk(
              path + '/dfmds-${widget.varsion}.apk', 'com.shinho.dfmdsappuat')
          .then((result) {
        print('install apk $result');
      }).catchError((error) {
        print('install apk error: $error');
      });
    } catch (_) {}
  }

  _init() async {
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      print(progress);
      setState(() => this.progress = progress);
      if (taskId == id && status == DownloadTaskStatus.complete) {
        _installApk();
        Navigator.of(context, rootNavigator: true).pop();
      }
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Material(
        type: MaterialType.transparency,
        child: Center(
          child: Container(
            width: pxUnit(280),
            height: pxUnit(366),
            child: Column(
              children: <Widget>[
                Container(
                  width: pxUnit(280),
                  height: pxUnit(166),
                  padding: EdgeInsets.fromLTRB(15, 50, 0, 0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/assets/images/version.png'),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '是否升级到V${widget.varsion}版本',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '新版本大小：32.0M',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: pxUnit(280),
                  height: pxUnit(200),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0),
                    ),
                  ),
                  child: Stack(
                    children: <Widget>[
                      ListView(
                        padding: EdgeInsets.fromLTRB(15, 0, 20, 0),
                        children: <Widget>[
                          Text(
                            '1、优化api接口',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF666666)),
                          ),
                          Text(
                            '2、添加demo演示',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF666666)),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 15,
                        child: Column(
                          children: <Widget>[
                            progress != null
                                ? Container(
                                    width: pxUnit(280),
                                    padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                                    child: LinearProgressIndicator(
                                      value: progress / 100,
                                    ),
                                  )
                                : SizedBox(),
                            SizedBox(height: 10),
                            Container(
                              width: pxUnit(280),
                              height: 38,
                              padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                              child: RaisedButton(
                                child: Text('立即更新',
                                    style: TextStyle(fontSize: 16.0)),
                                color: Color.fromRGBO(72, 123, 255, 1),
                                textColor: Colors.white,
                                elevation: 10,
                                onPressed: _download,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async {
        return Future.value(false);
      },
    );
  }
}
