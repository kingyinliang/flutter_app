import 'package:flutter/material.dart';

class MdsCard extends StatefulWidget {
  final Widget child;
  MdsCard({Key key, @required this.child}) : super(key: key);

  @override
  _MdsCardState createState() => _MdsCardState();
}

class _MdsCardState extends State<MdsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 12, 10),
      padding: EdgeInsets.fromLTRB(10, 14, 10, 14),
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
      child: widget.child,
    );
  }
}
