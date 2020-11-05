import 'package:flutter/material.dart';
import 'package:dfmdsapp/api/api/index.dart';
import 'package:dfmdsapp/components/pagesComponents/list.dart';

class ExceptionHome extends StatefulWidget {
  final arguments;
  ExceptionHome({Key key, this.arguments}) : super(key: key);

  @override
  _ExceptionHomeState createState() => _ExceptionHomeState();
}

class _ExceptionHomeState extends State<ExceptionHome> {
  var potOrder;

  @override
  Widget build(BuildContext context) {
    return ListPageWidget(
      title: widget.arguments['title'],
      api: Sterilize.sterilizeExceptionHomeListApi,
      params: {
        'potNo': widget.arguments['pot'],
        'workShop': widget.arguments['workShopId'],
        'type': 'semiReceive',
        'potOrder': potOrder,
      },
      tabsStatus: 'saveType',
      hintText: '锅序号',
      searchFn: (val) {
        this.potOrder = val;
        setState(() {});
      },
      tabs: [
        {'label': '未录入', 'type': '0'},
        {'label': '已录入', 'type': '1'},
      ],
      itemOnTap: (context, index, listviewList) {
        return Navigator.pushNamed(context, '/sterilize/exception/list',
            arguments: {
              'potName': widget.arguments['potName'],
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
                    Text('第${listviewList[index]['potOrder']}锅',
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
