
import 'package:ehsfocus/screens/forms/shared_form_components/audit_list-element.dart';
import 'package:flutter/material.dart';

class AuditFormWraper extends StatelessWidget {
  final String title;
  final int order;
  final String subtitle;
  final List<Widget> children;
  AuditFormWraper({this.children, this.title, this.order , this.subtitle});
  @override
  Widget build(BuildContext context) {
    List<Widget> exisisting = [
      AuditListElement(
        title: title == null ? null : title,
        order: order,
        subtitle: subtitle == null ? null : subtitle,
        isDone: false,
        onTap: () {},
      ),
    ];
    List<Widget> getWIdgets() {
      exisisting.addAll(children);
      return exisisting;
    }

    return Column(
      children: getWIdgets(),
    );
  }
}