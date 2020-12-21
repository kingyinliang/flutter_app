import 'package:dfmdsapp/utils/index.dart';

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
  List<String> searchHistory = [];

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
    var tmp = await SharedUtil.instance.getStorage('searchHistory');
    if (tmp != null) {
      searchHistory = await SharedUtil.instance.getStorage('searchHistory');
    }
    print(tmp);
    setState(() {});
  }

  goSearch() async {
    int index = searchHistory.indexOf(_search.text);
    if (index != -1) {
      searchHistory.removeAt(index);
    }
    searchHistory.insert(0, _search.text);
    if (searchHistory.length > 12) {
      searchHistory = searchHistory.sublist(0, 12);
    }
    await SharedUtil.instance
        .saveStringListStorage('searchHistory', searchHistory);
    searchHistory = await SharedUtil.instance.getStorage('searchHistory');
    setState(() {});
    Navigator.pop(context, _search.text);
  }

  getHistory() {
    List<Widget> searchList = [];
    searchList = searchHistory.asMap().keys.map((index) {
      return InkWell(
        onTap: () {
          _search.text = searchHistory[index];
          goSearch();
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(12, 3, 12, 3),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.all(Radius.circular(17)),
          ),
          child: Text(searchHistory[index]),
        ),
      );
    }).toList();
    if (searchList.length > 0) {
      return [
        Container(
          padding: EdgeInsets.fromLTRB(15, 20, 10, 10),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  '历史记录',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              InkWell(
                onTap: () async {
                  await SharedUtil.instance
                      .saveStringListStorage('searchHistory', null);
                  searchHistory = [];
                  setState(() {});
                },
                child: Icon(IconData(0xe674, fontFamily: 'MdsIcon'), size: 16),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 30),
          color: Colors.white,
          child: Wrap(
            spacing: 10,
            runSpacing: 8,
            children: searchList,
          ),
        ),
      ];
    } else {
      return [Container()];
    }
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
            keyboardType: TextInputType.number,
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
            onTap: () async {
              goSearch();
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
      body: ListView(
        children: getHistory(),
      ),
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
