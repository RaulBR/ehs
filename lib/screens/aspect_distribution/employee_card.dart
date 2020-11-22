import 'package:flutter/material.dart';

import '../../theme.dart';

class EmployeeCard extends StatelessWidget {
  final String action;
  final String name;
  final String date;
  const EmployeeCard({Key key, this.action, this.name, this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        action,
        style: TextStyle(color: AppColors.textPrimery),
      ),
      Container(
        // width: 100,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      Text(date == null ? '' : date),
    ]);
  }
}
