import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  ListPage({Key key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController mControll3 = TextEditingController();
    //Scaffold是Material中主要的布局组件.
    return new Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.blue,
          tooltip: 'Back',
          onPressed: () {
            print('Back');
          },
        ),
        title: Text(
          '工艺控制',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: <Widget>[
//          new IconButton(
//            icon: Icon(Icons.more_horiz),
//            color: Colors.blue,
//            tooltip: 'More',
//            onPressed: () {}
//          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_horiz, color: Colors.blue),
            color: Colors.blue,
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
              this.SelectView(Icons.home, '首页', '1'),
              this.SelectView(Icons.person, '我的', '2'),
            ],
            onSelected: (String action) {
              // 点击选项的时候
              switch (action) {
                case '1':
                  print("首页");
                  break;
                case '2':
                  print("我的");
                  break;
              }
            },
          ),
        ],
      ),
      //body占屏幕的大部分
//      body: ListViewDemo(),
      body: Column(children: <Widget>[
        Container(
            child: Container(
                height: 60.0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                  child: Card(
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 5.0,
                          ),
                          Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: TextField(
                                controller: mControll3,
                                decoration: new InputDecoration(
                                    contentPadding: EdgeInsets.only(top: -16.0),
                                    hintText: '锅序号',
                                    border: InputBorder.none),
                                // onChanged: onSearchTextChanged,
                              ),
                            ),
                          ),
                          new IconButton(
                            icon: new Icon(Icons.cancel),
                            color: Colors.grey,
                            iconSize: 18.0,
                            onPressed: () {
                              print('test');
                              mControll3.clear();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ))),
        Container(
//            height: 50.0,
//            color: Colors.white,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(width: 1, color: Color(0xffD5D5D5)))),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          '未录入',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Color(0xff1778FF),
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                    Container(
                      height: 2.0,
                      color: Color(0xff1778FF),
                      width: 60.0,
                    )
                  ],
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      '已保存',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                flex: 1,
              ),
              Expanded(
                child: Container(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      '已提交',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                flex: 1,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListViewDemo(),
        )
      ]),
//      floatingActionButton: FloatingActionButton(
//        tooltip: 'Add', // used by assistive technologies
//        child: Icon(Icons.add),
//        onPressed: null,
//      ),
    );
  }

  // 右上角下拉
  SelectView(IconData icon, String text, String id) {
    return PopupMenuItem<String>(
        value: id,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(icon, color: Colors.white),
            Text(text),
          ],
        ));
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
//              onTap: () {
//                showDialog(
//                  context: context,
//                  builder: (BuildContext context) {
//                    return AlertDialog(
//                      title: Text(
//                        'success',
//                        style: TextStyle(
//                          color: Colors.black54,
//                          fontSize: 18.0,
//                        ),
//                      ),
//                      content: Text('选择的item内容为:${_items[idx]}'),
//                    );
//                  },
//                );
//              },
            ));
      },
    );
  }
}
