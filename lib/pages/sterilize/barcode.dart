import 'package:flutter/material.dart';
import 'package:dfmdsapp/components/appBar.dart';
import 'package:dfmdsapp/api/api/index.dart';
import 'package:dfmdsapp/utils/storage.dart';
import 'package:dfmdsapp/utils/picker.dart';
import 'package:honeywell_scanner/honeywell_scanner.dart';
// import 'package:barcode_scan/barcode_scan.dart';
// import 'package:flutter_dong_scan/scan.dart';

class BarCodePage extends StatefulWidget {
  final arguments;
  BarCodePage({Key key, this.arguments}) : super(key: key);

  @override
  _BarCodePageState createState() => _BarCodePageState();
}

class _BarCodePageState extends State<BarCodePage>
    with WidgetsBindingObserver
    implements ScannerCallBack {
  HoneywellScanner honeywellScanner = HoneywellScanner();
  String scannedCode = '';
  List potList = [];

  _getPotList() async {
    var workShop = await SharedUtil.instance.getStorage('workShopId');
    try {
      var res = await Common.holderDropDownQuery({
        'deptId': workShop,
        'holderType': ['014']
      });
      potList = res['data'];
      setState(() {});
    } catch (e) {}
  }

  _selectPot() {
    PickerTool.showOneRow(
      context,
      selectVal: '',
      data: potList,
      label: 'holderName',
      value: 'holderNo',
      clickCallBack: (val) {
        _goList(val);
      },
    );
  }

  _goList(val) async {
    String urlString = '/sterilize/list';
    if (widget.arguments['url'] == '/sterilize/exception/home') {
      urlString = widget.arguments['url'];
    }
    var arguments = {
      'workShopId': widget.arguments['workShopId'],
      'pot': val['holderNo'],
      'potName': val['holderName'],
      'url': widget.arguments['url'],
      'title': widget.arguments['title'],
      'workingType': widget.arguments['workingType'],
    };
    Future.delayed(
      Duration(milliseconds: 1),
      () => setState(() {
        Navigator.of(context).pushNamed(
          urlString,
          arguments: arguments,
        );
      }),
    );
  }

  _scanSuccess(id) async {
    try {
      var res = await Common.holderDetailById({'id': id});
      _goList(res['data']);
      setState(() {});
    } catch (e) {}
  }

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () => setState(() {
        _getPotList();
        _initState();
      }),
    );
    super.initState();
  }

  _initState() {
    WidgetsBinding.instance.addObserver(this);
    honeywellScanner.setScannerCallBack(this);
    List<CodeFormat> codeFormats = [];
    codeFormats.addAll(CodeFormatUtils.ALL_1D_FORMATS);
    codeFormats.addAll(CodeFormatUtils.ALL_2D_FORMATS);
    honeywellScanner
        .setProperties(CodeFormatUtils.getAsPropertiesComplement(codeFormats));
    honeywellScanner.startScanner();
  }

  @override
  void dispose() {
    super.dispose();
    honeywellScanner.resumeScanner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MdsAppBarWidget(titleData: '二维码'),
      backgroundColor: Color(0xFFF5F5F5),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Container(
                height: 200,
                alignment: Alignment.center,
                child: Text(
                  '请使用pad两侧扫码按钮扫码或手动录入',
                  style: TextStyle(fontSize: 16, color: Color(0xFF1677FF)),
                ),
              ),
            ],
          ),
          Positioned(
            right: 20,
            bottom: 20,
            child: Container(
              width: 70,
              height: 70,
              child: RawMaterialButton(
                shape: CircleBorder(),
                splashColor: Colors.amber[100],
                fillColor: Color(0xFF1677FF),
                child: Icon(
                  IconData(0xe642, fontFamily: 'MdsIcon'),
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  _selectPot();
                },
              ),
            ),
          ),
          // Container(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: <Widget>[
          //       Text('请使用pad两侧扫码按钮扫码或手动录入'),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }

  @override
  void onDecoded(String result) {
    setState(() {
      scannedCode = result;
      _scanSuccess(scannedCode);
    });
  }

  @override
  void onError(Exception error) {
    setState(() {
      scannedCode = error.toString();
    });
  }
}
