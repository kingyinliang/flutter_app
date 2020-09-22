import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
          width: 280,
          child: Image.asset(
            'lib/assets/images/nodata.png',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
