import 'package:flutter/material.dart';
import 'package:dfmdsapp/api/api/index.dart';
import 'package:dfmdsapp/components/pagesComponents/list.dart';

class KojiMakingListPage extends StatefulWidget {
  final arguments;
  KojiMakingListPage({Key key, this.arguments}) : super(key: key);

  @override
  _KojiMakingListPageState createState() => _KojiMakingListPageState();
}

class _KojiMakingListPageState extends State<KojiMakingListPage> {
  var orderNo;
  List tabs = [];
  @override
  void initState() {
    if (widget.arguments['workingType'] == 'STEAM_FLOUR_EXCEPTION' ||
        widget.arguments['workingType'] == 'DISC_EXCEPTION' ||
        widget.arguments['workingType'] == 'STEAM_BEAN_EXCEPTION') {
      print(11);
      tabs = [
        {'label': '未录入', 'type': 'N'},
        {'label': '已录入', 'type': 'S'},
      ];
    } else {
      tabs = [
        {'label': '待维护', 'type': 'N'},
        {'label': '已保存', 'type': 'S'},
        {'label': '已提交', 'type': 'D'}
      ];
    }
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListPageWidget(
      title: widget.arguments['title'],
      api: KojiMaking.kojiMakingList,
      tabs: tabs,
      tabsStatus: 'status',
      params: {
        'workShop': widget.arguments['workShopId'],
        'listType': widget.arguments['workingType'],
        'orderNo': orderNo,
      },
      searchFn: (val) {
        this.orderNo = val;
        setState(() {});
      },
      itemOnTap: (context, index, listviewList) {
        return Navigator.pushNamed(context, widget.arguments['url'],
            arguments: {
              'title': widget.arguments['title'],
              'data': listviewList[index],
              'workingType': widget.arguments['workingType']
            });
      },
      itemBuilder: (context, index, listviewList) {
        return Container(
          color: Colors.white,
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
          child: Row(
            children: <Widget>[
              Container(
                width: 52,
                height: 60,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/assets/images/potDetail.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  color: Color(0xF2F2F2FF),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    listviewList[index]['kojiHouseName'] == ''
                        ? SizedBox()
                        : Text(
                            '${listviewList[index]['kojiHouseName']}',
                            style: TextStyle(
                                fontSize: 17, color: Color(0xFF333333)),
                          ),
                    Text(
                      '${listviewList[index]['materialCode']} ${listviewList[index]['materialName']}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 13, color: Color(0xFF999999)),
                    ),
                    Text(
                      '${listviewList[index]['orderNo']}',
                      style: TextStyle(fontSize: 13, color: Color(0xFF999999)),
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Text(
                    '${listviewList[index]['statusName']}',
                    style: TextStyle(fontSize: 13, color: Color(0xFF333333)),
                  ),
                  Text(
                    '${listviewList[index]['productDate']}',
                    style: TextStyle(fontSize: 13, color: Color(0xFF666666)),
                  ),
                ],
              ),
              Icon(
                Icons.keyboard_arrow_right,
                size: 16,
                color: Color(0xFFCCCCCC),
              ),
            ],
          ),
        );
      },
    );
  }
}
