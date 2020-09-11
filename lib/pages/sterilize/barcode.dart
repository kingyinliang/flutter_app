import 'package:flutter/material.dart';
import 'package:dfmdsapp/api/api/index.dart';
import 'package:dfmdsapp/utils/storage.dart';

class BarCodePage extends StatefulWidget {
  final arguments;
  BarCodePage({Key key, this.arguments}) : super(key: key);

  @override
  _BarCodePageState createState() => _BarCodePageState();
}

class _BarCodePageState extends State<BarCodePage> {
  List potList = [];

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
      body: Container(
        child: ListView.builder(
          itemCount: potList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/sterilize/list',
                  arguments: {
                    'pot': potList[index]['holderNo'],
                    'potName': potList[index]['holderName'],
                    'url': widget.arguments['url'],
                    'title': widget.arguments['title'],
                    'workingType': widget.arguments['workingType'],
                  },
                );
              },
              child: Center(
                child: Text(potList[index]['holderName']),
              ),
            );
          },
        ),
      ),
    );
  }
}
