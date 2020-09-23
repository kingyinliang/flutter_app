import 'package:flutter/material.dart';
import 'package:dfmdsapp/components/appBar.dart';
import 'package:dfmdsapp/api/api/index.dart';
import 'package:dfmdsapp/utils/storage.dart';
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
    var workShop = await getStorage('workShopId');
    try {
      var res = await Common.holderDropDownQuery(
          {'deptId': workShop, 'holderType': '014'});
      potList = res['data'];
      setState(() {});
    } catch (e) {}
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
      body: Container(
        child: ListView(
          children: <Widget>[
            InkWell(
              onTap: _barcode,
              child: Container(
                alignment: Alignment.center,
                width: 100,
                height: 50,
                color: Colors.blue,
                child: Text('扫一扫'),
              ),
            ),
            SizedBox(height: 10),
            Text(string1.toString()),
            SizedBox(height: 10),
            InkWell(
              onTap: _dongscan,
              child: Container(
                alignment: Alignment.center,
                width: 100,
                height: 50,
                color: Colors.blue,
                child: Text('扫一扫'),
              ),
            ),
            SizedBox(height: 10),
            Text(string2.toString()),
            SizedBox(height: 10),
            Column(
              children: potList.asMap().keys.map((index) {
                return InkWell(
                  onTap: () {
                    String urlString = '/sterilize/list';
                    if (widget.arguments['blockType'] == 'exception') {
                      urlString = widget.arguments['url'];
                    }
                    Navigator.pushNamed(
                      context,
                      urlString,
                      arguments: {
                        'pot': potList[index]['holderNo'],
                        'potName': potList[index]['holderName'],
                        'url': widget.arguments['url'],
                        'title': widget.arguments['title'],
                        'workingType': widget.arguments['workingType'],
                        'typeParameters': widget.arguments['typeParameters'],
                      },
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: Text(potList[index]['holderName']),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}