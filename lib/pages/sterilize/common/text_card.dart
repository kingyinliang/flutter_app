import 'package:flutter/material.dart';
import '../../../components/card.dart';

// 单个card
class TextCard extends StatefulWidget {
  final Function onTap;
  final List dataList; // 数据列表
  final String text;
  final int idx;
  final bool isEdit; // 是否显示修改按钮
  TextCard(
      {Key key,
      this.dataList,
      this.text,
      this.onTap,
      this.idx,
      this.isEdit = true})
      : super(key: key);
  @override
  _TextCardState createState() => _TextCardState();
}

class _TextCardState extends State<TextCard> {

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
                    Text('${widget.dataList[widget.idx][widget.text]}'),
                    SizedBox(height: 10),
//                    Row(
//                        mainAxisAlignment: MainAxisAlignment.end,
//                        children: <Widget>[
//                          Text('16080028 2019-15',
//                            style: TextStyle(
//                              height: 1.5,
//                              fontSize: 14.0,
//                              color: Color(0xFF666666),
//                            ),
//                          ),
//                        ]
//                    )
                  ]
              )
            ]
        )
    );
  }
}
