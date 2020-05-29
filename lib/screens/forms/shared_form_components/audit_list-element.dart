import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/screens/forms/ehs_asplect_list.dart';

class AuditListElement extends StatelessWidget {
  final String title;
  final String subtitle;
  final int order;
  final bool isDone;
  final Widget trailing;
  final Function onTap;

  AuditListElement(
      {this.title,
      this.subtitle,
      this.order,
      this.isDone,
      this.trailing,
      @required this.onTap});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: auditList,
      leading: AuditListAvatar(order: '$order', isDone: isDone),
      trailing: trailing ?? null,
      title: Text(
        title,
        style: TextStyle(fontSize: 18),
      ),
      subtitle: subtitle == null ? Text('') : Text(subtitle),
      onTap: () => onTap(),
    );
  }
}

class DropDownAuditListElement extends StatelessWidget {
  final String title;
  final String subtitle;
  final int order;
  final bool isDone;
  final Function onTap;
  final Function selected;
  final List<dynamic> aspects;

  DropDownAuditListElement(
      {this.title,
      this.subtitle,
      this.order,
      this.isDone,
      this.onTap,
      this.aspects,
      this.selected});

  @override
  Widget build(BuildContext context) {
    String setSubtitle() {
      String subtitle = '';
      if (aspects.length != 0) {
        subtitle = 'Aspecte adaugate: ${aspects.length}';
      }
      return subtitle;
    }

    return ExpansionTile(
        tilePadding: EdgeInsets.fromLTRB(0, 0, 20, 0),
        title: AuditListElement(
            title: title,
            subtitle: setSubtitle(),
            order: order,
            isDone: isDone,
            onTap: () => onTap()),
        children: [
          EhsAspectList(
              aspects: aspects == null ? [] : aspects,
              selected: (data) {
                selected(data);
              }),
          SizedBox(
            width: double.infinity,
            child: FlatButton.icon(
              onPressed: () => onTap(),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              icon: Icon(Icons.add),
              label: Text('add'),
            ),
          ),
        ]);
  }
}

class AuditListAvatar extends StatelessWidget {
  final String order;
  final bool isDone;

  AuditListAvatar({
    this.order,
    this.isDone,
  });
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 15,
      backgroundColor: AppColors.green[300],
      child: isDone
          ? Icon(
              Icons.done,
              color: AppColors.icons,
            )
          : Text((order == null ? '' : order),
              style: TextStyle(color: AppColors.icons)),
    );
  }
}
