import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomGroupButtons extends StatelessWidget {
  final bool isLast;
  final bool isFirst;
  final bool isEnabled;
  final Function navigate;
  final Function submit;
  BottomGroupButtons(
      {this.navigate, this.submit, this.isFirst, this.isLast, this.isEnabled});
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: isFirst
                    ? Text('')
                    : Row(
                        children: [
                          Icon(
                            Icons.chevron_left,
                            color: AppColors.icons,
                          ),
                          isFirst
                              ? Text('')
                              : Text(
                                  Labels.back,
                                  style: TextStyle(color: AppColors.icons),
                                ),
                        ],
                      ),
                onPressed: isFirst ? null : () => navigate(-1),
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(30.0),
                // ),
              ),
              TextButton(
                child: !isEnabled
                    ? Text('')
                    : Row(
                        children: [
                          Text(
                            isLast ? Labels.close : Labels.next,
                            style: TextStyle(color: AppColors.icons),
                          ),
                          isLast
                              ? Text('')
                              : Icon(
                                  Icons.chevron_right,
                                  color: AppColors.icons,
                                ),
                        ],
                      ),
                onPressed: !isEnabled ? null : () => navigate(1),
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(30.0),
                // ),
              ),
            ],
          )),
    );
  }
}
