import 'package:flutter/material.dart';

class MdsWidthButton extends StatefulWidget {
  final String text;
  final Function onPressed;

  MdsWidthButton({Key key, this.text, this.onPressed}) : super(key: key);

  @override
  _MdsWidthButtonState createState() => _MdsWidthButtonState();
}

class _MdsWidthButtonState extends State<MdsWidthButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: Container(
        width: double.infinity,
        height: 49.0,
        child: RaisedButton(
            child: Text(
              '${widget.text}',
              style: TextStyle(fontSize: 18.0),
            ),
            color: Color.fromRGBO(72, 123, 255, 1),
            textColor: Colors.white,
            elevation: 10,
            onPressed: widget.onPressed),
      ),
    );
  }
}
