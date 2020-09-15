import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SuccessToast extends StatelessWidget {
  const SuccessToast({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(
        Icons.done,
        color: Colors.white,
      ),
    );
  }
}

class ErrorToast extends StatelessWidget {
  const ErrorToast({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(
        Icons.close,
        color: Colors.white,
      ),
    );
  }
}

class InfoToast extends StatelessWidget {
  const InfoToast({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(
        Icons.info,
        color: Colors.white,
      ),
    );
  }
}

class WarningToast extends StatelessWidget {
  const WarningToast({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(
        Icons.warning,
        color: Colors.white,
      ),
    );
  }
}

successToast({msg: '提交成功'}) {
  EasyLoading.show(status: msg, indicator: SuccessToast());
  Future.delayed(
    Duration(milliseconds: 2000),
    () {
      EasyLoading.dismiss();
    },
  );
}

errorToast({msg: '提交失败'}) {
  EasyLoading.show(status: msg, indicator: ErrorToast());
  Future.delayed(
    Duration(milliseconds: 2000),
    () {
      EasyLoading.dismiss();
    },
  );
}

infoToast({msg: '信息'}) {
  EasyLoading.show(status: msg, indicator: InfoToast());
  Future.delayed(
    Duration(milliseconds: 2000),
    () {
      EasyLoading.dismiss();
    },
  );
}

warningToast({msg: '警告'}) {
  EasyLoading.show(status: msg, indicator: WarningToast());
  Future.delayed(
    Duration(milliseconds: 2000),
    () {
      EasyLoading.dismiss();
    },
  );
}
