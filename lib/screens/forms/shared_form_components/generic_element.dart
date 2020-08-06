import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';

class GennericListElement extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function isSelected;
  final Function deleted;
  final String simbol;
  GennericListElement(
      {this.title, this.subtitle, this.isSelected, this.simbol, this.deleted});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(3),
      child: Card(
        borderOnForeground: false,
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          onTap: () async {
            isSelected();
          },
          leading: simbol == null
              ? null
              : CircleAvatar(
                  radius: 25,
                  backgroundColor: AppColors.lightprimary,
                  child: Text(simbol ?? 'P'),
                ),
          trailing: deleted == null
              ? null
              : FlatButton.icon(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    deleted();
                  },
                  label: null,
                ),
          title: Text(title == null ? 'no data' : title),
          subtitle: Text(subtitle == null ? '' : subtitle),
          // trailing: FlatButton(
          //   shape: new CircleBorder(),
          //   child: Icon(Icons.close),
          //   onPressed: () {
          //     isSelected();
          //   },
          // ),
        ),
      ),
    );
  }
}
