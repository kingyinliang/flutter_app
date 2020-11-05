import 'package:dfmdsapp/utils/index.dart';
import 'package:dfmdsapp/components/search.dart';
import 'package:dfmdsapp/utils/pxunit.dart';

class OrgSelectUserPage extends StatefulWidget {
  final arguments;
  OrgSelectUserPage({Key key, this.arguments}) : super(key: key);

  @override
  _OrgSelectUserPageState createState() => _OrgSelectUserPageState();
}

class _OrgSelectUserPageState extends State<OrgSelectUserPage> {
  bool selectAll = false;
  bool orgOrUser = false;

  List orgTree = [];
  List selectOrg = [];
  List orgList = [];

  List userList = [];
  List selectUserList = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () => setState(() {
        _initState();
      }),
    );
  }

  _initState() async {
    _getOrg();
    _setSelectUser();
  }

  // 初始化选中人员
  void _setSelectUser() {
    if (widget.arguments != null && widget.arguments['selectUser'] != null) {
      widget.arguments['selectUser'].forEach((element) {
        var realName = element.substring(0, element.indexOf('('));
        var workNum =
            element.substring(element.indexOf('(') + 1, element.indexOf(')'));
        selectUserList.add({
          'realName': realName,
          'workNum': workNum,
        });
        print(selectUserList);
        setState(() {});
      });
    }
  }

  // 获取组织架构数
  void _getOrg() async {
    var factoryId = await SharedUtil.instance.getStorage('factoryId');
    try {
      var res = await Common.orgTreeQuery({'factory': factoryId});
      orgTree = res['data'];
      orgList = orgTree;
      setState(() {});
    } catch (e) {}
  }

  // 顶部面包屑
  List<Widget> _getSelectOrgName() {
    List<Widget> nameList = [];
    nameList = selectOrg.asMap().keys.map((index) {
      return InkWell(
        onTap: () {
          textOn(selectOrg[index], index);
        },
        child: Text(
          '/${selectOrg[index]['label']}',
          style: TextStyle(
            fontSize: 14,
            height: 1.5,
            color: Color(0xFF999999),
          ),
        ),
      );
    }).toList();
    return nameList;
  }

  // 面包屑点击
  void textOn(data, index) {
    orgOrUser = false;
    selectAll = false;
    selectOrg.removeRange(index + 1, selectOrg.length);
    orgList = data['children'];
    setState(() {});
  }

  // 组织架构点击
  void itemOn(data) {
    orgOrUser = true;
    selectAll = false;
    selectOrg.add(data);
    getUser(data);
    setState(() {});
  }

  // 获取下一级
  void getChildren(data) {
    orgList.forEach((element) {
      if (element['id'] == data['id']) {
        orgList = element['children'];
        selectOrg.add(element);
      }
    });
    setState(() {});
  }

  // 根据组织架构获取人员
  void getUser(data) async {
    userList = [];
    try {
      var res = await Common.getUserByOrgTree({'deptId': data['id']});
      userList = res['data'] == null ? [] : res['data'];
      setState(() {});
    } catch (e) {}
  }

  // 人员点击增加人员
  void selectUser(data) {
    selectUserList.add(data);
    setState(() {});
  }

  // 人员点击删除人员
  void delUser(data) {
    for (var index = 0; index < selectUserList.length; index++) {
      if (selectUserList[index]['workNum'] != null &&
          selectUserList[index]['workNum'] != '') {
        if (selectUserList[index]['workNum'] == data['workNum'] ||
            selectUserList[index]['workNum'] == data['workNumTemp']) {
          selectUserList.removeAt(index);
          index--;
          setState(() {});
        }
      } else {
        if (selectUserList[index]['workNumTemp'] != null &&
            selectUserList[index]['workNumTemp'] == data['workNumTemp']) {
          selectUserList.removeAt(index);
          index--;
          setState(() {});
        }
      }
    }
  }

  // 底部点击删除人员
  void delUserItem(index) {
    selectUserList.removeAt(index);
    setState(() {});
  }

  // 全选
  selectAllUser() {
    selectAll = !selectAll;
    if (orgOrUser) {
      userList.forEach((element) {
        bool status = false;
        selectUserList.forEach((item) {
          if (item['workNum'] != null && item['workNum'] != '') {
            if (item['workNum'] == element['workNum'] ||
                item['workNum'] == element['workNumTemp']) {
              status = true;
            }
          } else {
            if (item['workNumTemp'] != null &&
                item['workNumTemp'] == element['workNumTemp']) {
              status = true;
            }
          }
        });
        if (status && !selectAll) {
          delUser(element);
        }
        if (!status && selectAll) {
          selectUser(element);
        }
      });
    }
    setState(() {});
  }

  searchUser(String text) async {
    orgOrUser = true;
    selectAll = false;
    userList = [];
    print(text);
    try {
      print(selectOrg[selectOrg.length - 1]['id']);
      var res = await Common.getUserByQuery({
        'workNum': text,
        'deptId': selectOrg[selectOrg.length - 1]['id'],
        'current': '1',
        'size': '99999',
      });
      userList = res['data']['records'] == null ? [] : res['data']['records'];
      setState(() {});
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.blue,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '人员选择',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Scaffold(
          backgroundColor: Color(0xFFF5F5F5),
          appBar: AppBar(
            backgroundColor: Color(0xFFF5F5F5),
            automaticallyImplyLeading: false,
            title: HeadSearchWidget(
              hintText: '工号/姓名',
              searchFn: (String text) {
                searchUser(text);
              },
            ),
            elevation: 1.5,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(48),
              child: Material(
                color: Colors.white,
                child: Container(
                  width: double.infinity,
                  height: 48,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 16),
                        InkWell(
                          child: selectAll
                              ? Icon(
                                  IconData(0xe60e, fontFamily: 'MdsIcon'),
                                  color: Color(0xFF1677FF),
                                  size: 16,
                                )
                              : Icon(
                                  IconData(0xe61f, fontFamily: 'MdsIcon'),
                                  color: Color(0xFF979797),
                                  size: 16,
                                ),
                          onTap: selectAllUser,
                        ),
                        SizedBox(width: 10),
                        Text(
                          '全选',
                          style: TextStyle(
                            fontSize: 17,
                            color: Color(0xFF333333),
                          ),
                        ),
                        SizedBox(width: 5),
                        Row(
                          children: _getSelectOrgName(),
                        ),
                        SizedBox(width: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0,
                    selectUserList.length != 0 ? pxUnit(190) : pxUnit(48)),
                child: orgOrUser
                    ? UserWidget(
                        selectUserList: selectUserList,
                        userList: userList,
                        delUser: delUser,
                        selectUser: selectUser,
                      )
                    : OrgWidget(
                        orgList: orgList,
                        itemOn: itemOn,
                        getChildren: getChildren,
                      ),
              ),
              OrgSelectUserBottom(
                  selectUserList: selectUserList, delUser: delUserItem)
            ],
          ),
        ),
      ),
    );
  }
}

class OrgWidget extends StatefulWidget {
  final List orgList;
  final Function itemOn;
  final Function getChildren;
  OrgWidget({Key key, this.orgList, this.itemOn, this.getChildren})
      : super(key: key);

  @override
  _OrgWidgetState createState() => _OrgWidgetState();
}

class _OrgWidgetState extends State<OrgWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.orgList.length,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.white,
          height: 48,
          padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFF999999), width: 0.25),
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: () {
                      widget.itemOn(widget.orgList[index]);
                    },
                    child: Text(
                      '${widget.orgList[index]['label']}',
                      style: TextStyle(color: Color(0xFF333333), fontSize: 17),
                    ),
                  ),
                ),
                widget.orgList[index]['children'].length != 0
                    ? Container(
                        width: 1,
                        height: 18,
                        color: Color(0xFFD8D8D8),
                      )
                    : SizedBox(),
                widget.orgList[index]['children'].length != 0
                    ? Container(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: InkWell(
                          onTap: () {
                            widget.getChildren(widget.orgList[index]);
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                IconData(
                                  0xe668,
                                  fontFamily: 'MdsIcon',
                                ),
                                size: 16,
                                color: Color(0xFF1677FF),
                              ),
                              Text(
                                '下级',
                                style: TextStyle(
                                    color: Color(0xFF1677FF), fontSize: 14),
                              )
                            ],
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class UserWidget extends StatefulWidget {
  final List userList;
  final List selectUserList;
  final Function selectUser;
  final Function delUser;
  UserWidget(
      {Key key,
      this.userList,
      this.selectUserList,
      this.selectUser,
      this.delUser})
      : super(key: key);

  @override
  _UserWidgetState createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  bool _getSelectStatus(data) {
    bool status = false;
    widget.selectUserList.forEach((element) {
      if (element['workNum'] != null && element['workNum'] != '') {
        if (element['workNum'] == data['workNum'] ||
            element['workNum'] == data['workNumTemp']) {
          status = true;
        }
      } else {
        if (element['workNumTemp'] != null &&
            element['workNumTemp'] == data['workNumTemp']) {
          status = true;
        }
      }
    });
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.userList.length,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.white,
          height: 48,
          padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFF999999), width: 0.25),
              ),
            ),
            child: Row(
              children: <Widget>[
                InkWell(
                  child: _getSelectStatus(widget.userList[index])
                      ? Icon(
                          IconData(0xe60e, fontFamily: 'MdsIcon'),
                          color: Color(0xFF1677FF),
                          size: 16,
                        )
                      : Icon(
                          IconData(0xe61f, fontFamily: 'MdsIcon'),
                          color: Color(0xFF979797),
                          size: 16,
                        ),
                  onTap: () {
                    if (_getSelectStatus(widget.userList[index])) {
                      widget.delUser(widget.userList[index]);
                    } else {
                      widget.selectUser(widget.userList[index]);
                    }
                  },
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '${widget.userList[index]['realName']}(${widget.userList[index]['workNum'] != null && widget.userList[index]['workNum'] != '' ? widget.userList[index]['workNum'] : widget.userList[index]['workNumTemp']})',
                    style: TextStyle(color: Color(0xFF333333), fontSize: 17),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class OrgSelectUserBottom extends StatefulWidget {
  final List selectUserList;
  final Function delUser;
  OrgSelectUserBottom({Key key, this.selectUserList, this.delUser})
      : super(key: key);

  @override
  _OrgSelectUserBottomState createState() => _OrgSelectUserBottomState();
}

class _OrgSelectUserBottomState extends State<OrgSelectUserBottom> {
  List<Widget> getGridView() {
    List<Widget> widgetList = [];
    widgetList = widget.selectUserList.asMap().keys.map((index) {
      return InkWell(
        onTap: () {
          widget.delUser(index);
        },
        child: Container(
          width: pxUnit(171.5),
          height: 28,
          child: Row(
            children: <Widget>[
              Icon(
                IconData(0xe60e, fontFamily: 'MdsIcon'),
                color: Color(0xFF1677FF),
                size: 16,
              ),
              SizedBox(width: 5),
              Text(
                '${widget.selectUserList[index]['realName']}',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 17,
                ),
              ),
              Text(
                '(${widget.selectUserList[index]['workNum'] != null && widget.selectUserList[index]['workNum'] != '' ? widget.selectUserList[index]['workNum'] : widget.selectUserList[index]['workNumTemp']})',
                style: TextStyle(
                  color: Color(0xFF999999),
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: pxUnit(375),
      bottom: 0,
      child: Column(
        children: <Widget>[
          widget.selectUserList.length != 0
              ? Container(
                  color: Color(0xFF999999),
                  height: pxUnit(1),
                )
              : SizedBox(),
          widget.selectUserList.length != 0
              ? Container(
                  color: Colors.white,
                  width: pxUnit(375),
                  height: pxUnit(140),
                  padding: EdgeInsets.fromLTRB(pxUnit(16), 10, pxUnit(16), 0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Wrap(
                      children: getGridView(),
                    ),
                  ),
                )
              : SizedBox(),
          Container(
            padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
            child: Container(
              color: Color(0xFF999999),
              height: pxUnit(1),
            ),
          ),
          Container(
            height: pxUnit(48),
            padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    '已选择：${widget.selectUserList.length}人',
                    style: TextStyle(
                      fontSize: 17,
                      color: Color(0xFF487BFF),
                    ),
                  ),
                ),
                Container(
                  height: 32,
                  width: 74,
                  child: RaisedButton(
                    child: Text(
                      '确定',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    color: Color(0xFF487BFF),
                    elevation: 10,
                    onPressed: () {
                      Navigator.pop(context, widget.selectUserList);
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
