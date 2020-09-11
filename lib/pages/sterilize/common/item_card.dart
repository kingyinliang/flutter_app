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
  ItemCard(
      {Key key,
      this.carTitle = '',
      this.onTap,
      this.cardMap,
      this.title,
      this.subTitle,
      this.wrapList})
      : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  List colorList = [0xFFCDDDFD, 0xFFD3EEF9, 0xFFF8D0CB, 0xFFCDF3E4, 0xFFFCEBB9];
  int index = -1;
  @override
  Widget build(BuildContext context) {
    return MdsCard(
      child: Stack(
        children: <Widget>[
          Positioned(
            right: 0,
            top: 0,
            child: InkWell(
              onTap: widget.onTap,
              child: Icon(
                IconData(0xe62c, fontFamily: 'MdsIcon'),
                size: 16,
                color: Color(0xFF487BFF),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                      widget.cardMap[widget.title] == null
                          ? ''
                          : widget.cardMap[widget.title].toString(),
                      style: TextStyle(
                          height: 1.0,
                          fontSize: 40.0,
                          color: Color(0xFF242446),
                          fontWeight: FontWeight.w500)),
                  Text(
                      widget.cardMap[widget.subTitle] == null
                          ? ''
                          : widget.cardMap[widget.subTitle].toString(),
                      style: TextStyle(
                          fontSize: 12.0,
                          color: Color(0xFF333333),
                          height: 3.0)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    IconData(0xe621, fontFamily: 'MdsIcon'),
                    size: 12.0,
                    color: Color(0xFF999999),
                  ),
                  SizedBox(width: 3.0),
                  Text(widget.carTitle,
                      style:
                          TextStyle(fontSize: 12.0, color: Color(0xFF666666))),
                ],
              ),
              SizedBox(height: 14),
              Wrap(
                spacing: 10,
                runSpacing: 8,
                children: widget.wrapList.asMap().keys.map((i) {
                  if (index > 3) {
                    index = -1;
                  }
                  index++;
                  return widget.cardMap[widget.wrapList[i]['value']] == null ||
                          widget.cardMap[widget.wrapList[i]['value']] == ''
                      ? Text('')
                      : Container(
                          padding: EdgeInsets.fromLTRB(12, 3, 12, 3),
                          decoration: BoxDecoration(
                            color: Color(colorList[index]),
                            borderRadius: BorderRadius.all(Radius.circular(17)),
                          ),
                          child: Text(
                            widget.wrapList[i]['label'] +
                                (widget.cardMap[widget.wrapList[i]['value']] ==
                                        null
                                    ? ''
                                    : widget
                                        .cardMap[widget.wrapList[i]['value']]
                                        .toString()),
                            style: TextStyle(fontSize: 13, height: 1.4),
                          ),
                        );
                }).toList(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
