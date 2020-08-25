import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../components/appBar.dart';
import '../common/headerDetail.dart';

class MaterialList extends StatefulWidget {
  MaterialList({Key key}) : super(key: key);

  @override
  _MaterialListState createState() => _MaterialListState();
}

class _MaterialListState extends State<MaterialList> {
  @override
  Widget build(BuildContext context) {

    String titleData = '工艺控制';
    void onChanged(val){
      setState(() {
        titleData = val;
      });
    }

    List detialArray = ['1#锅 第2锅', '杀菌完黄豆酱', '83300023456', '83300023456'];
    void onChangeds(val){
      setState(() {
        detialArray = val;
      });
    }

    return new Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: MdsAppBarWidget(titleData: titleData,callBack: (value) => onChanged(value)),
      body: Column(
        children: <Widget>[
//          Container(
//            margin: EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
//            padding: EdgeInsets.all(10.0),
//            color: Colors.white,
//            child: PotDetail(detialArray: detialArray,callBack: (value) => onChangeds(value))
//          ),
          headerDetail(detialArray: detialArray,callBack: (value) => onChangeds(value)),
          Container(
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            '入料&升温',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Color(0xff1778FF),
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                      Container(
                        height: 2.0,
                        color: Color(0xff1778FF),
                        width: 60.0,
                      )
                    ],
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Container(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        '杀菌时间&温度',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                  flex: 1,
                ),
              ]


            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add', // used by assistive technologies
        child: Icon(Icons.add),
        onPressed: null,
      ),
    );
  }
}
