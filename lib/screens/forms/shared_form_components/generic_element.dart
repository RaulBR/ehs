import 'package:ehsfocus/screens/forms/shared_form_components/status_element.dart';
import 'package:ehsfocus/shared/loading.dart';
import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';

class GennericListElement extends StatelessWidget {
  final String error;
  final String title;
  final String subtitle;
  final Function isSelected;
  final Function deleted;
  final bool isThreeLine;
  final String simbol;
  GennericListElement(
      {this.title,
      this.subtitle,
      this.isSelected,
      this.simbol,
      this.deleted,
      this.isThreeLine,
      this.error});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(3),
      child: Card(
        borderOnForeground: false,
        clipBehavior: Clip.antiAlias,
        child: Container(
          decoration: error == null
              ? null
              : BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: AppColors.errorColor, width: 1)),
                ),
          child: ListTile(
            onTap: () async {
              isSelected();
            },
            leading: simbol == null ? null : StatusWidget(status: simbol),
            trailing: deleted == null
                ? null
                : GestureDetector(
                    onTap: () => deleted(), child: Icon(Icons.close)),
            title: title == null
                ? LoadingSimbol(
                    size: 10,
                    color: AppColors.accent,
                  )
                : Text(title == null ? 'no data' : title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subtitle == null ? '' : subtitle),
                error == null
                    ? StatusTextWidget(status: simbol)
                    : Text(
                        error,
                        style: TextStyle(color: AppColors.errorColor),
                      ),
              ],
            ),
            isThreeLine: isThreeLine == null ? false : isThreeLine,
            // trailing: FlatButton(
            //   shape: new CircleBorder(),
            //   child: Icon(Icons.close),
            //   onPressed: () {
            //     isSelected();
            //   },
            // ),
          ),
        ),
      ),
    );
  }
}
