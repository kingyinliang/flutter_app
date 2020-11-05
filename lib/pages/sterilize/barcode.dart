import 'package:flutter/material.dart';
import 'package:dfmdsapp/components/appBar.dart';
import 'package:dfmdsapp/api/api/index.dart';
import 'package:dfmdsapp/utils/storage.dart';
import 'package:dfmdsapp/utils/picker.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter_dong_scan/scan.dart';

class BarCodePage extends StatefulWidget {
  final arguments;
  BarCodePage({Key key, this.arguments}) : super(key: key);

  @override
  _BarCodePageState createState() => _BarCodePageState();
}

class _BarCodePageState extends State<BarCodePage> {
  List potList = [];
  var string1;
  var string2;

  _barcode() async {
    print(1);
    var result = await BarcodeScanner.scan(
      options: ScanOptions(
        strings: {
          'cancel': '取消',
          'flash_on': '打开闪光灯',
          'flash_off': '关闭闪光灯',
        },
      ),
    );
    string1 = result;
    setState(() {});
    print(result.type);
    print(result.rawContent);
    print(result.format);
    print(result.formatNote);
  }

  _dongscan() {
    ScanConfig scanConfig = ScanConfig();
    SDScan scan = SDScan().setScanEventListener((dynamic codeString) {
      print("扫描结果:" + codeString);
      string2 = codeString;
      setState(() {});
    });
    scan.startScan(config: scanConfig);
  }

  _getPotList() async {
    var workShop = await SharedUtil.instance.getStorage('workShopId');
    try {
      var res = await Common.holderDropDownQuery(
          {'deptId': workShop, 'holderType': '014'});
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

  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(string1 ?? ''),
        Text(string2 ?? ''),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 70,
              height: 70,
              child: RawMaterialButton(
                shape: CircleBorder(),
                splashColor: Colors.amber[100],
                fillColor: Color(0xFF1677FF),
                child: Icon(
                  IconData(0xe6ca, fontFamily: 'MdsIcon'),
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: _dongscan,
              ),
            ),
            SizedBox(width: 50),
            Container(
              width: 70,
              height: 70,
              child: RawMaterialButton(
                shape: CircleBorder(),
                splashColor: Colors.amber[100],
                fillColor: Color(0xFF1677FF),
                child: Icon(
                  IconData(0xe632, fontFamily: 'MdsIcon'),
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: _selectPot,
              ),
            ),
          ],
        )
      ],
    );
  }

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () => setState(() {
        _getPotList();
      }),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MdsAppBarWidget(titleData: '二维码'),
      backgroundColor: Color(0xFFF5F5F5),
      body: body(),
    );
  }
}
