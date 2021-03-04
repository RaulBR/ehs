import 'package:ehsfocus/models/form_metadata.dart/form_footer_model.dart';
import 'package:ehsfocus/shared/form_eleements/form_footer.dart';
import 'package:ehsfocus/shared/form_eleements/generic_list__search_page/generic_list_page_search.dart';
import 'package:flutter/material.dart';
import 'package:ehsfocus/shared/constants.dart';

class PageWrapper extends StatelessWidget {
  final Widget appBarr;
  final Widget child;
  final Function footerAction;
  final Function add;
  final List<FormFooterModel> footerActions;
  const PageWrapper({
    Key key,
    this.child,
    this.footerAction,
    this.footerActions,
    this.add,
    this.appBarr,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool _isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0.0;
    List<FormFooterModel> _formActions = footerActions == null
        ? [FormFooterModel(Labels.delete), FormFooterModel(Labels.save)]
        : footerActions;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomPadding: false,
      appBar: appBarr == null ? null : appBarr,
      body: BodyContainer(child: child),
      bottomNavigationBar: _isKeyboard || footerAction == null
          ? null
          : FormFooter(
              actions: _formActions,
              action: footerActions == null
                  ? null
                  : (action) {
                      footerAction(action);
                    },
            ),
      floatingActionButton: add == null
          ? null
          : FloatingActionButton(
              onPressed: () {
                add();
              },
              child: Icon(Icons.add),
            ),
    );
  }
}
