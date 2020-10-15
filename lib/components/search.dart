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
  final arguments;
  SearchWidget({Key key, this.arguments}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  var _search = new TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () => setState(() {
        _initState();
      }),
    );
  }

  _initState() async {
    _search.text =
        widget.arguments['text'] == '' ? '' : widget.arguments['text'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Color(0xFF1677FF),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Container(
          height: 30,
          child: TextField(
            style: TextStyle(color: Color(0xFF999999), fontSize: 13),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0.0),
              prefixIcon: Icon(Icons.search, color: Color(0xFF999999)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: BorderSide(
                  color: Color(0xFF1677FF),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: BorderSide(
                  color: Color(0xFF1677FF),
                ),
              ),
              hintText: widget.arguments['hintText'],
              fillColor: Color(0xFF999999),
            ),
            controller: _search,
          ),
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.pop(context, _search.text);
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
              child: Text(
                '搜索',
                style: TextStyle(color: Color(0xFF1677FF), fontSize: 15),
              ),
            ),
          )
        ],
      ),
      body: Container(),
    );
  }
}

class HeadSearchWidget extends StatefulWidget {
  final String hintText;
  final Function searchFn;
  HeadSearchWidget({Key key, this.hintText = '订单号', this.searchFn})
      : super(key: key);

  @override
  _HeadSearchWidgetState createState() => _HeadSearchWidgetState();
}

class _HeadSearchWidgetState extends State<HeadSearchWidget> {
  String text;
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
            Navigator.pushNamed(context, '/search', arguments: {
              'hintText': widget.hintText,
              'text': text ?? '',
            }).then((value) {
              if (value != null) {
                this.text = value;
                widget.searchFn(value);
              }
              setState(() {});
            });
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
                  text == null || text == '' ? widget.hintText : text,
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
