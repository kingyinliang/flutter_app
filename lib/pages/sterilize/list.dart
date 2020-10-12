import 'package:flutter/material.dart';
import 'package:dfmdsapp/api/api/index.dart';
import 'package:dfmdsapp/components/pagesComponents/list.dart';

class AcceAddListPage extends StatefulWidget {
  final arguments;
  AcceAddListPage({Key key, this.arguments}) : super(key: key);

  @override
  _AcceAddListPageState createState() => _AcceAddListPageState();
}

class _AcceAddListPageState extends State<AcceAddListPage> {
  @override
  Widget build(BuildContext context) {
    return ListPageWidget(
      title: widget.arguments['title'],
      api: Sterilize.sterilizeListApi,
      params: {
        'workShop': widget.arguments['workShopId'],
        'workingType': widget.arguments['workingType'],
        'potNo': widget.arguments['pot'],
      },
      itemOnTap: (context, index, listviewList) {
        return Navigator.pushNamed(context, widget.arguments['url'],
            arguments: {
              'status': listviewList[index]['status'],
              'statusName': listviewList[index]['statusName'],
              'pot': widget.arguments['pot'],
              'potName': widget.arguments['potName'],
              'potNum': listviewList[index],
            });
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
                Text(
                    '${listviewList[index]['orderNo']}-${listviewList[index]['statusName']}'),
              ],
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
        );
      },
    );
  }
}
