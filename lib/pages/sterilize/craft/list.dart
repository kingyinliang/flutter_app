import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dfmdsapp/components/appBar.dart';
import 'package:dfmdsapp/api/api/index.dart';
import 'package:dfmdsapp/utils/storage.dart';

class CraftListPage extends StatefulWidget {
  final arguments;
  CraftListPage({Key key, this.arguments}) : super(key: key);

  @override
  _CraftListPageState createState() => _CraftListPageState();
}

class _CraftListPageState extends State<CraftListPage> {
  @override
  Widget build(BuildContext context) {
//    TextEditingController mControll3 = TextEditingController();
    //Scaffold是Material中主要的布局组件.

//    String titleData = '工艺控制';
//    void onChanged(val){
//      setState(() {
//        titleData = val;
//      });
//    }
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            backgroundColor: Color(0xffF5F5F5),
            appBar: MdsAppBarWidget(titleData: '工艺控制'),
            body: Container(
                child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: Color(0xFFF5F5F5),
                      automaticallyImplyLeading: false,
                      title: HeadSearchWidget(),
                      elevation: 1.5,
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(42),
                        child: Material(
                          color: Colors.white,
                          child: TabBar(
                            indicatorSize: TabBarIndicatorSize.label,
                            indicatorColor: Color(0xFF1677FF),
                            labelColor: Color(0xFF1677FF),
                            labelStyle: TextStyle(fontSize: 17),
                            unselectedLabelColor: Color(0xFF333333),
                            unselectedLabelStyle: TextStyle(fontSize: 17),
                            tabs: <Widget>[
                              Tab(text: '待维护'),
                              Tab(text: '已保存'),
                              Tab(text: '已提交'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    backgroundColor: Color(0xFFF5F5F5),
                    body: TabBarView(
                      children: <Widget>[
                        ListItemWidget(
                            type: 'not', url: widget.arguments['url']),
                        ListItemWidget(
                            type: 'save', url: widget.arguments['url']),
                        ListItemWidget(
                            type: 'submit', url: widget.arguments['url']),
                      ],
                    )))));

//    return new Scaffold(
//      backgroundColor: Color(0xffF5F5F5),
//      appBar: MdsAppBarWidget(titleData: titleData,callBack: (value) => onChanged(value)),
//      //body占屏幕的大部分
////      body: ListViewDemo(),
//      body: Column(children: <Widget>[
//        Container(
//            child: Container(
//                height: 60.0,
//                child: Padding(
//                  padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
//                  child: Card(
//                    child: Container(
//                      child: Row(
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        children: <Widget>[
//                          SizedBox(
//                            width: 5.0,
//                          ),
//                          Icon(
//                            Icons.search,
//                            color: Colors.grey,
//                          ),
//                          Expanded(
//                            child: Container(
//                              alignment: Alignment.center,
//                              child: TextField(
//                                controller: mControll3,
//                                decoration: new InputDecoration(
//                                    contentPadding: EdgeInsets.only(top: -16.0),
//                                    hintText: '锅序号',
//                                    border: InputBorder.none),
//                                // onChanged: onSearchTextChanged,
//                              ),
//                            ),
//                          ),
//                          new IconButton(
//                            icon: new Icon(Icons.cancel),
//                            color: Colors.grey,
//                            iconSize: 18.0,
//                            onPressed: () {
//                              print('test');
//                              mControll3.clear();
//                            },
//                          ),
//                        ],
//                      ),
//                    ),
//                  ),
//                ))),
//        Container(
////            height: 50.0,
////            color: Colors.white,
//          decoration:
//            BoxDecoration(
//              color: Colors.white,
//              border: Border(
//                bottom: BorderSide(width: 1, color: Color(0xffD5D5D5))
//              )
//            ),
//          child: Row(
//            children: <Widget>[
//              Expanded(
//                child: Column(
//                  children: <Widget>[
//                    Container(
//                        padding: EdgeInsets.all(5.0),
//                        child: Text(
//                          '待维护',
//                          textAlign: TextAlign.center,
//                          style: TextStyle(
//                            fontSize: 18.0,
//                            color: Color(0xff1778FF),
//                            fontWeight: FontWeight.w600,
//                          ),
//                        )),
//                    Container(
//                      height: 2.0,
//                      color: Color(0xff1778FF),
//                      width: 60.0,
//                    )
//                  ],
//                ),
//                flex: 1,
//              ),
//              Expanded(
//                child: Container(
//                    padding: EdgeInsets.all(5.0),
//                    child: Text(
//                      '已保存',
//                      textAlign: TextAlign.center,
//                      style: TextStyle(
//                        fontSize: 18.0,
//                        fontWeight: FontWeight.w600,
//                      ),
//                    )),
//                flex: 1,
//              ),
//              Expanded(
//                child: Container(
//                    padding: EdgeInsets.all(5.0),
//                    child: Text(
//                      '已提交',
//                      textAlign: TextAlign.center,
//                      style: TextStyle(
//                        fontSize: 18.0,
//                        fontWeight: FontWeight.w600,
//                      ),
//                    )),
//                flex: 1,
//              ),
//            ],
//          ),
//        ),
//        Expanded(
//          child: ListViewDemo(),
//        )
//      ]),
////      floatingActionButton: FloatingActionButton(
////        tooltip: 'Add', // used by assistive technologies
////        child: Icon(Icons.add),
////        onPressed: null,
////      ),
//    );
  }
}

class HeadSearchWidget extends StatefulWidget {
  HeadSearchWidget({Key key}) : super(key: key);
  @override
  _HeadSearchWidgetState createState() => _HeadSearchWidgetState();
}

class _HeadSearchWidgetState extends State<HeadSearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
      height: 44,
      color: Color(0xFFF5F5F5),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0x0A000000),
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        child: TextField(
          style: TextStyle(color: Color(0xFF999999), fontSize: 13),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0.0),
            prefixIcon: Icon(Icons.search, color: Color(0xFF999999)),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            hintText: '锅序号',
            fillColor: Color(0xFF999999),
          ),
        ),
      ),
    );
  }
}

class ListItemWidget extends StatefulWidget {
  final String type;
  final String pot;
  final String potName;
  final String url;
  final String workingType;
  ListItemWidget(
      {Key key,
      @required this.url,
      @required this.pot,
      @required this.potName,
      @required this.type,
      @required this.workingType})
      : super(key: key);

  @override
  _ListItemWidgetState createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemWidget>
    with AutomaticKeepAliveClientMixin {
  List listviewList = [];
  _initState() async {
    var workShopId = await SharedUtil.instance.getStorage('workShopId');
    try {
      var res = await Sterilize.sterilizeCraftListApi({
        'workShop': workShopId,
        'type': widget.type,
        'current': '1',
        'size': '10',
      });
      listviewList = res['data']['records'];
      setState(() {});
    } catch (e) {}
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration.zero,
        () => setState(() {
              _initState();
            }));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      itemCount: listviewList.length,
      itemBuilder: (context, index) {
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
                    '${listviewList[index]['orderNo']}-${listviewList[index]['checkStatusName']}'),
              ],
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.pushNamed(context, '/sterilize/craft/materialList',
                  arguments: {
                    'potName': widget.potName,
                    'potNum': listviewList[index],
                  });
            },
          ),
        );
      },
    );
  }
}

class ListViewDemo extends StatelessWidget {
  final _items = List<String>.generate(1000, (i) => "Item $i");
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1000,
      itemBuilder: (context, idx) {
        return Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(0, 15.0, 0, 15.0),
            margin: EdgeInsets.only(bottom: 6.0),
            child: ListTile(
              leading: CircleAvatar(
                child: Image.asset("lib/assets/images/pot.jpg"),
              ),
//              title: Text(
//                '第${_items[idx]}锅',
//                style: TextStyle(
//                  fontSize: 17.0
//                )
//              ),
              title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.ltr,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('第${idx}锅', style: TextStyle(fontSize: 17.0)),
                        Text(
                          ' - 保温20m',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ]),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.ltr,
                children: <Widget>[
                  Text('SP05060101杀菌完黄豆酱'),
                  Text('833000342134-未录入'),
                ],
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                print('详情${_items[idx]}');
              },
            ));
      },
    );
  }
}
