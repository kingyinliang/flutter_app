import 'package:flutter/material.dart';
import 'package:dfmdsapp/utils/pxunit.dart';

class DiaLogContainer extends StatefulWidget {
  final double width;
  final double height;
  final Widget child;
  final Function success;
  DiaLogContainer(
      {Key key, this.child, this.success, this.width = 300, this.height = 223})
      : super(key: key);

  @override
  _DiaLogContainerState createState() => _DiaLogContainerState();
}

class _DiaLogContainerState extends State<DiaLogContainer> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Material(
        type: MaterialType.transparency,
        child: Center(
          child: Container(
            width: pxUnit(widget.width),
            height: pxUnit(widget.height),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  width: pxUnit(widget.width),
                  child: widget.child,
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Container(
                    width: pxUnit(widget.width),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 1, color: Color(0XFFD8D8D8)),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            child: Center(
                              child: Text(
                                '取消',
                                style: TextStyle(
                                    color: Color(0xFF3D7FFF), fontSize: 14),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 42,
                          color: Color(0XFFD8D8D8),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            child: Center(
                              child: Text(
                                '确定',
                                style: TextStyle(
                                    color: Color(0xFF3D7FFF), fontSize: 14),
                              ),
                            ),
                            onTap: () {
                              widget.success();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async {
        return Future.value(false);
      },
    );
  }
}
