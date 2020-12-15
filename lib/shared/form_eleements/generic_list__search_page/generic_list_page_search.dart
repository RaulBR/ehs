import 'package:ehsfocus/models/generic_list_model.dart';
import 'package:ehsfocus/shared/ehs_generic_list.dart';
import 'package:ehsfocus/shared/form_eleements/form_footer.dart';
import 'package:flutter/material.dart';
import 'package:ehsfocus/shared/constants.dart';

class SearchPageWrapper extends StatefulWidget {
  final String title;
  final String searchLabel;
  final List<GenericListObject> listObjects;
  final Widget customListWidget;
  final Widget addForm;
  final Function search;
  final Function deleted;
  final Function selected;
  final Function add;
  const SearchPageWrapper({
    Key key,
    this.title,
    this.searchLabel,
    this.search,
    this.addForm,
    this.deleted,
    this.selected,
    this.listObjects,
    this.add,
    this.customListWidget,
  }) : super(key: key);

  @override
  _SearchPageWrapperState createState() => _SearchPageWrapperState();
}

class _SearchPageWrapperState extends State<SearchPageWrapper> {
  final GlobalKey<ScaffoldState> _scaffoldstate = GlobalKey<ScaffoldState>();
  bool _isAddVisible = true;
  openWidget(Widget input) {
    handleBottomFooter();
    PersistentBottomSheetController bottomSheetController =
        _scaffoldstate.currentState.showBottomSheet(
      (context) => input,
      clipBehavior: Clip.hardEdge,
    );

    bottomSheetController.closed.then((value) {
      handleBottomFooter();
    });
  }

  handleBottomFooter() {
    setState(() {
      _isAddVisible = !_isAddVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool _isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return Scaffold(
      key: _scaffoldstate,
      appBar: AppBar(actions: <Widget>[], title: Text(widget.title)),
      body: BodyContainer(
        child: Column(
          children: <Widget>[
            TextField(
              decoration: textInputDecoration.copyWith(
                  labelText: widget.searchLabel ?? widget.title,
                  suffixIcon: Icon(Icons.search)),
              onChanged: (data) {
                widget.search(data);
              },
            ),
            SizedBox(height: 20),
            Flexible(
              child: widget.customListWidget != null
                  ? widget.customListWidget
                  : EhsGenericList(
                      listElements: widget.listObjects,
                      deleted: widget.deleted == null
                          ? null
                          : (data) {
                              widget.deleted(data);
                            },
                      selected: (data) {
                        widget.selected(data);
                        openWidget(widget.addForm);
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: !_isAddVisible || _isKeyboard || widget.add == null
          ? null
          : FloatingActionButton(
              onPressed: () {
                if (widget.addForm != null) {
                  widget.add();
                  openWidget(widget.addForm);
                }
              },
              child: Icon(Icons.add),
            ),
    );
  }
}

class PageWrapper extends StatelessWidget {
  final Widget appBarr;
  final Widget child;
  final Function footerAction;
  final Function add;
  final List<String> footerActions;
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
    List<String> _formActions =
        footerActions == null ? [Labels.delete, Labels.save] : footerActions;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
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

class BodyContainer extends StatelessWidget {
  final Widget child;
  const BodyContainer({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: 400,
          margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
          alignment: AlignmentDirectional.topCenter,

          // child: SingleChildScrollView(
          child: child),
    );
  }
}
