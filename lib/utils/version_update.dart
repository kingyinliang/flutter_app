import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:package_info/package_info.dart';
import 'package:dfmdsapp/components/dialog.dart';
import 'package:permission_handler/permission_handler.dart';

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

  _download() async {
    if (await Permission.storage.request().isGranted) {
      final path = (await getExternalStorageDirectory()).path.toString();

      //发起请求
      final taskId = await FlutterDownloader.enqueue(
          url: widget.url,
          fileName: 'dfmds-${widget.varsion}.apk',
          savedDir: path,
          showNotification: true,
          openFileFromNotification: false);

      FlutterDownloader.registerCallback((id, status, progress) {
        //更新下载进度
        setState(() => this.progress = progress);

        // 当下载完成时，调用安装
        if (taskId == id && status == DownloadTaskStatus.complete) {
          //关闭更新进度框
          // Navigator.of(context).pop();
          //安装下载完的apk
          // BackUpdate()._installApk();
          FlutterDownloader.open(taskId: taskId);
        }
      });
    }
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
