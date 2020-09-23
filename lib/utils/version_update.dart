import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:package_info/package_info.dart';
import 'package:dfmdsapp/components/dialog.dart';
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
              path + '/dfmds-${widget.varsion}.apk', 'com.shinho.dfmdsapp')
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
      }
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void initState() {
    _init();
    super.initState();
    FlutterDownloader.initialize();
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DiaLogContainer(
      success: _download,
      child: Center(
        child: Text('进度:$progress'),
      ),
    );
  }
}
