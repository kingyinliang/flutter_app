import 'package:flutter/material.dart';

class MdsAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  MdsAppBarWidget({Key key}) : super(key: key);

  @override
  _MdsAppBarWidgetState createState() => _MdsAppBarWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(45);
}

class _MdsAppBarWidgetState extends State<MdsAppBarWidget> {
  selectView(IconData icon, String text, String id) {
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

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
        PopupMenuButton<String>(
          icon: Icon(Icons.more_horiz, color: Colors.blue),
          color: Colors.blue,
          itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
            this.selectView(Icons.home, '首页', '1'),
            this.selectView(Icons.person, '我的', '2'),
          ],
          onSelected: (String action) {
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
    );
  }
}
