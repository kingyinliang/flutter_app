import 'package:flutter/material.dart';
import 'package:dfmdsapp/api/api/index.dart';
import 'package:dfmdsapp/components/pagesComponents/list.dart';

class CraftHome extends StatefulWidget {
  final arguments;
  CraftHome({Key key, this.arguments}) : super(key: key);

  @override
  _CraftHomeState createState() => _CraftHomeState();
}

class _CraftHomeState extends State<CraftHome> {
  var potOrder;

  @override
  Widget build(BuildContext context) {
    return ListPageWidget(
      title: widget.arguments['title'],
      api: Sterilize.sterilizeCraftListApi,
      params: {
        'workShop': widget.arguments['workShopId'],
        'potOrder': potOrder,
      },
      hintText: '锅序号',
      searchFn: (val) {
        this.potOrder = val;
        setState(() {});
      },
      itemOnTap: (context, index, listviewList) {
        return Navigator.pushNamed(context, '/sterilize/craft/materialList',
            arguments: {
              'potName': widget.arguments['potName'],
              'potNum': listviewList[index],
              'potDetail': listviewList[index],
              'barTitle': widget.arguments['title'],
              'typeCode': widget.arguments['workingType'],
            }).then((value) => value != null ? ListPageWidget() : ListPageWidget());
      },
      itemBuilder: (context, index, listviewList) {
        return Container(
          color: Colors.white,
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
          child: ListTile(
            leading: CircleAvatar(
              child: Image.asset("lib/assets/images/pot.jpg"),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.ltr,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('${listviewList[index]['potName']} 第${listviewList[index]['potOrder']}锅',
                        style: TextStyle(fontSize: 17.0)),
                  ],
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.ltr,
              children: <Widget>[
                Text(
                    '${listviewList[index]['materialCode']} ${listviewList[index]['materialName']}'),
                Text('${listviewList[index]['orderNo']}'),
              ],
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
        );
      },
    );
  }
}
