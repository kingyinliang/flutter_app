import 'package:dfmdsapp/utils/index.dart';
import 'package:dfmdsapp/components/pagesComponents/list.dart';

class ExeptionListPage extends StatefulWidget {
  final arguments;
  ExeptionListPage({Key key, this.arguments}) : super(key: key);

  @override
  _ExeptionListPageState createState() => _ExeptionListPageState();
}

class _ExeptionListPageState extends State<ExeptionListPage> {
  @override
  Widget build(BuildContext context) {
    return ListPageWidget(
      title: widget.arguments['title'],
      api: Sterilize.sterilizeListApi,
      tabs: [
        {'label': '未录入', 'type': 'N'},
        {'label': '已录入', 'type': 'S'},
      ],
      params: {
        'workShop': '85002011',
        'workingType': widget.arguments['workingType'],
        'potNo': '1',
      },
      itemOnTap: (context, index, listviewList) {
        return Navigator.pushNamed(
          context,
          '/exeption',
          arguments: {
            'title': widget.arguments['title'],
            'status': listviewList[index]['status'],
            'statusName': listviewList[index]['statusName'],
            'pot': widget.arguments['pot'],
            'potName': widget.arguments['potName'],
            'potNum': listviewList[index],
          },
        );
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
                    Text(
                      '第${listviewList[index]['potOrder']}锅',
                      style: TextStyle(fontSize: 17, color: Color(0xFF333333)),
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
                    '2020-07-20',
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
        ;
      },
    );
  }
}
