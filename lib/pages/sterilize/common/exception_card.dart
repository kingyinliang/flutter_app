import 'package:flutter/material.dart';
import '../../../components/card.dart';

// 单个card
class ExceptionItemCard extends StatefulWidget {
  final int idx;
  final Function onTap;
  final String startTime;
  final String endTime;
  final Map cardMap;
  final List wrapList;
  final bool isEdit; // 是否显示修改按钮
  ExceptionItemCard(
      {Key key,
      this.idx,
      this.onTap,
      this.startTime,
      this.endTime,
      this.cardMap,
      this.wrapList,
      this.isEdit = true})
      : super(key: key);
  @override
  _ExceptionItemCardState createState() => _ExceptionItemCardState();
}

class _ExceptionItemCardState extends State<ExceptionItemCard> {
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('NO.${widget.idx+1}',
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
                    child: widget.isEdit ? InkWell(
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
                  Text(widget.cardMap[widget.startTime] == null ? '' : widget.cardMap[widget.startTime], style: TextStyle(fontSize: 16)),
                  Expanded(
                    child: Text(''),
                  ),
                  Text(widget.cardMap[widget.endTime] == null ? '' : widget.cardMap[widget.endTime], style: TextStyle(fontSize: 16))
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
