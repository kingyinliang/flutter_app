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

    String titleData = '工艺控制 ';
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
          HeaderDetail(detialArray: detialArray,callBack: (value) => onChangeds(value)),
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
                          )
                      ),
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
                      )
                  ),
                  flex: 1,
                ),
              ]
            ),
          ),
          Card(
            color: Colors.white,
            margin: EdgeInsets.all(5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            child: Container(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('入料时间', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      Expanded(
                        child: Text(''), // 中间用Expanded控件
                      ),
//                    Text('我是右边的', style: TextStyle(fontSize: 12)),
                      Icon(Icons.border_color,size: 16,color: Color(0xff1778FF),),
                    ],
                  ),
                  SizedBox(height: 6),
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
                      Text('2020.05.21 10:23', style: TextStyle(fontSize: 14)),
                      Expanded(
                        child: Text(''),
                      ),
                      Text('2020.05.21 10:23', style: TextStyle(fontSize: 14))
                    ],
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: <Widget>[
                      Text('入料时间', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      Expanded(
                        child: Text(''), // 中间用Expanded控件
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
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
                      Text('2020.05.21 10:23', style: TextStyle(fontSize: 14)),
                      Expanded(
                        child: Text(''),
                      ),
                      Text('2020.05.21 10:23', style: TextStyle(fontSize: 14))
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(12, 3, 12, 3),
                        decoration: BoxDecoration(
                            color: Color(0xFFF8D0CB),
                            borderRadius: BorderRadius.all(Radius.circular(17))),
                        child: Text('二次加热：否'),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        padding: EdgeInsets.fromLTRB(12, 3, 12, 3),
                        decoration: BoxDecoration(
                            color: Color(0xFFFCEBB9),
                            borderRadius: BorderRadius.all(Radius.circular(17))),
                        child: Text('二次保温：是'),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: Container(
              width: double.infinity,
//              decoration: BoxDecoration(
//                border: Border.all(
//                  color: Colors.black,
//                  width: 1,
//                ),
//              ),
              height: 50,
              margin: EdgeInsets.only(left: 30.0),
              child: RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                //设置按钮阴影
                elevation: 20,
                //设置圆角
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Text("提交"),
                onPressed: () {
                  print("圆角按钮");
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
