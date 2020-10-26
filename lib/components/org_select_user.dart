import 'package:dfmdsapp/utils/index.dart';

class OrgSelectUser extends StatefulWidget {
  final String label;
  final List prop;
  final bool requiredFlg;
  OrgSelectUser(
      {Key key,
      @required this.label,
      @required this.prop,
      this.requiredFlg = false})
      : super(key: key);

  @override
  _OrgSelectUserState createState() => _OrgSelectUserState();
}

class _OrgSelectUserState extends State<OrgSelectUser> {
  getName() {
    String name = '';
    widget.prop.forEach((element) {
      name += element;
    });
    return name;
  }

  onTap() {
    Navigator.pushNamed(
      context,
      '/orgSelectUser',
    );
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
              Text(
                getName(),
                style: TextStyle(color: Color(0xFF999999), fontSize: 15),
                textAlign: TextAlign.end,
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
