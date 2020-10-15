import 'package:flutter/material.dart';

Future showSearchFn(BuildContext context) async {
  showDialog(
    context: context,
    builder: (context) {
      return SearchWidget();
    },
  );
}

class SearchWidget extends StatefulWidget {
  SearchWidget({Key key}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Text('data'),
      ),
    );
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
        child: InkWell(
          onTap: () {
            showSearchFn(context);
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.search,
                  color: Color(0xFF999999),
                  size: 20,
                ),
                SizedBox(width: 10),
                Text(
                  '锅序号',
                  style: TextStyle(color: Color(0xFF999999), fontSize: 13),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// TextField(
//             style: TextStyle(color: Color(0xFF999999), fontSize: 13),
//             decoration: InputDecoration(
//               contentPadding: EdgeInsets.symmetric(vertical: 0.0),
//               prefixIcon: Icon(Icons.search, color: Color(0xFF999999)),
//               border: OutlineInputBorder(
//                 borderSide: BorderSide.none,
//               ),
//               hintText: '锅序号',
//               fillColor: Color(0xFF999999),
//             ),
//           )
