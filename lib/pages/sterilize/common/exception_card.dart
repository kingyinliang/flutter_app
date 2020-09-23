import 'package:flutter/material.dart';
import '../../../components/card.dart';

// 单个card
class ItemCard extends StatefulWidget {
  final Function onTap;
  final String carTitle;
  final String title;
  final String subTitle;
  final Map cardMap;
  final List wrapList;
  final bool submitButtonFlag;
  ItemCard(
      {Key key,
      this.carTitle = '',
      this.onTap,
      this.cardMap,
      this.title,
      this.subTitle,
      this.wrapList,
      this.submitButtonFlag})
      : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
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
    return MdsCard(
      child: Stack(
        children: <Widget>[
//          Positioned(
//            right: 0,
//            top: 0,
//            child: widget.submitButtonFlag ? InkWell(
//              onTap: widget.onTap,
//              child: Icon(
//                IconData(0xe62c, fontFamily: 'MdsIcon'),
//                size: 16,
//                color: Color(0xFF487BFF),
//              ),
//            ) : SizedBox(),
//          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('NO.1',
                      style: TextStyle(
                          height: 1.5,
                          fontSize: 14.0,
                          color: Color(0xFF666666),
                      ),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Container(
                    child: widget.submitButtonFlag ? InkWell(
                      onTap: widget.onTap,
                      child: Icon(
                        IconData(0xe62c, fontFamily: 'MdsIcon'),
                        size: 16,
                        color: Color(0xFF487BFF),
                      ),
                    ) : SizedBox(),
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Text('开始时间'),
                  Expanded(
                    child: Text(''),
                  ),
                  Text('结束时间')
                ],
              ),
              SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('2015-05-31 11:46', style: TextStyle(fontSize: 16)),
                  Expanded(
                    child: Text(''),
                  ),
                  Text('2020-05-31 11:46', style: TextStyle(fontSize: 16))
                ],
              ),
              SizedBox(height: 14),
              Wrap(
                spacing: 10,
                runSpacing: 8,
                children: _wrapList(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
