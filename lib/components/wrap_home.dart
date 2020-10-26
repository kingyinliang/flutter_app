import 'package:dfmdsapp/utils/index.dart';

class WrapWidget extends StatefulWidget {
  final Map cardMap;
  final List wrapList;
  WrapWidget({Key key, this.cardMap, this.wrapList}) : super(key: key);

  @override
  _WrapWidgetState createState() => _WrapWidgetState();
}

class _WrapWidgetState extends State<WrapWidget> {
  List colorList = [0xFFCDDDFD, 0xFFD3EEF9, 0xFFF8D0CB, 0xFFCDF3E4, 0xFFFCEBB9];
  int index = -1;

  List<Widget> _wrapList() {
    List<Widget> wrapList = [];
    widget.wrapList.asMap().keys.forEach((i) {
      if (widget.cardMap[widget.wrapList[i]['value']] == null ||
          widget.cardMap[widget.wrapList[i]['value']] == '') {
      } else {
        if (index > 3) {
          index = -1;
        }
        index++;
        wrapList.add(Container(
          padding: EdgeInsets.fromLTRB(12, 3, 12, 3),
          decoration: BoxDecoration(
            color: Color(colorList[index]),
            borderRadius: BorderRadius.all(Radius.circular(17)),
          ),
          child: Text(
            widget.wrapList[i]['label'] +
                (widget.cardMap[widget.wrapList[i]['value']] == null
                    ? ''
                    : widget.cardMap[widget.wrapList[i]['value']].toString()),
            style: TextStyle(fontSize: 13, height: 1.4),
          ),
        ));
      }
    });
    index = -1;
    return wrapList;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 8,
      children: _wrapList(),
    );
  }
}
