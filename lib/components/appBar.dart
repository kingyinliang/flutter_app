import 'package:flutter/material.dart';

class MdsAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  MdsAppBarWidget({Key key, this.titleData, this.callBack}) : super(key: key);
  final String titleData;
  final callBack;

  @override
  _MdsAppBarWidgetState createState() => _MdsAppBarWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(45);
}

class _MdsAppBarWidgetState extends State<MdsAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        color: Colors.blue,
        tooltip: 'Back',
        onPressed: () {
          print('Back');
          Navigator.pop(context);
        },
      ),
      title: Text(
        '${widget.titleData}',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
      ),
      centerTitle: true,
      elevation: 1.5,
      backgroundColor: Colors.white,
      actions: <Widget>[
        GestureDetector(
          child: Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(Icons.more_horiz, color: Colors.blue),
          ),
          onTap: () async {
            final result = await showMenu(
                context: context,
                position: RelativeRect.fromLTRB(500, 75, 10, 0),
                color: Color(0xFF4C4C4C),
                items: <PopupMenuEntry<String>>[
                  this.selectView(Icons.home, '首页', '1'),
                  PopupMenuDivider(height: 1.0),
                  this.selectView(Icons.person, '我的', '2'),
                ]);
            print(result);
          },
        )
//        PopupMenuButton<String>(
//          icon: Icon(Icons.more_horiz, color: Colors.blue),
//          color: Colors.blue,
//          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
//            this.selectView(Icons.home, '首页', '1'),
//            PopupMenuDivider(height: 1.0),
//            this.selectView(Icons.person, '我的', '2'),
//          ],
//          onSelected: (String action) {
//            switch (action) {
//              case '1':
//                print("首页");
//                break;
//              case '2':
//                print("我的");
//                break;
//            }
//          },
//        ),
      ],
    );
  }

  selectView(IconData icon, String text, String id) {
    return PopupMenuItem<String>(
        value: id,
        height: 35.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
//            Icon(icon, color: Colors.white),
//            Text(text),
            Container(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(icon, color: Colors.white)),
            Text(text, style: TextStyle(color: Colors.white)),
          ],
        ));
  }
}
