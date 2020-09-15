import 'package:flutter/material.dart';
import 'package:dfmdsapp/components/slide_button.dart';

// 删除按钮
class CardRemoveBtn extends StatefulWidget {
  final Function removeOnTab;
  CardRemoveBtn({Key key, this.removeOnTab}) : super(key: key);

  @override
  _CardRemoveBtnState createState() => _CardRemoveBtnState();
}

class _CardRemoveBtnState extends State<CardRemoveBtn> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 70.0,
        height: double.infinity,
        margin: EdgeInsets.fromLTRB(5, 0, 0, 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 3.0),
              color: Color(0x0C000000),
              blurRadius: 4.0,
              spreadRadius: 0,
            )
          ],
        ),
        child: Center(
          child: Container(
            height: 40,
            child: RaisedButton(
                color: Colors.red,
                shape: CircleBorder(side: BorderSide(color: Colors.red)),
                child: Icon(IconData(0xe674, fontFamily: 'MdsIcon'),
                    color: Colors.white, size: 30),
                onPressed: () {
                  eventBus.fire(IndexEvent(0));
                  widget.removeOnTab();
                }),
          ),
        ),
      ),
      onTap: () {
        eventBus.fire(IndexEvent(0));
        widget.removeOnTab();
      },
    );
  }
}
