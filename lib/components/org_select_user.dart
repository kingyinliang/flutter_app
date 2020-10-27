import 'package:dfmdsapp/utils/index.dart';

class OrgSelectUser extends StatefulWidget {
  final String label;
  final List prop;
  final bool requiredFlg;
  final Function onChange;
  OrgSelectUser(
      {Key key,
      @required this.label,
      @required this.prop,
      @required this.onChange,
      this.requiredFlg = false})
      : super(key: key);

  @override
  _OrgSelectUserState createState() => _OrgSelectUserState();
}

class _OrgSelectUserState extends State<OrgSelectUser> {
  getName() {
    String name = '';
    widget.prop.forEach((element) {
      name += element + ',';
    });
    return name;
  }

  onTap() {
    Navigator.pushNamed(
      context,
      '/orgSelectUser',
      arguments: {
        'selectUser': widget.prop,
      },
    ).then((dynamic value) {
      if (value != null) {
        List userList = [];
        value.forEach((element) {
          var item =
              '${element['realName']}(${element['workNum'] != null && element['workNum'] != '' ? element['workNum'] : element['workNumTemp']})';
          userList.add(item);
        });
        widget.onChange(userList);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FormItem(
      label: widget.label,
      requiredFlg: widget.requiredFlg,
      child: InkWell(
        child: Container(
          height: 48,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      getName(),
                      style: TextStyle(color: Color(0xFF999999), fontSize: 15),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: Color(0xFFCCCCCC),
              )
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
