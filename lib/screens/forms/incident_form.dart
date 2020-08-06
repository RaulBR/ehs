import 'package:ehsfocus/models/audit_head_modal.dart';
import 'package:ehsfocus/models/aspects_model.dart';
import 'package:ehsfocus/screens/forms/area/area_form.dart';
import 'package:ehsfocus/screens/forms/aspects/photo_comment_form.dart';
import 'package:ehsfocus/screens/forms/shared_form_components/audit_list_element.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/ehs_slider.dart';
import 'package:ehsfocus/shared/navigation_form/navigation_wrapper.dart';
import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';

class IncidentForm extends StatefulWidget {
  @override
  _IncidentFormState createState() => _IncidentFormState();
}

class _IncidentFormState extends State<IncidentForm> {
  final GlobalKey<ScaffoldState> _scaffoldstate = GlobalKey<ScaffoldState>();
  bool isFormOpened = false;
  List<Aspect> _negativeAspects = [];
  List<String> inputList = ['TF1', 'TF2', 'TF3', 'TF4', 'TF5'];
  int stepValue = 0;
  AuditHead area;
  String test;

  Widget getNav(int number) {
    return EhsNavigatorWidget(
      displayWidgets: [
        AreaFromWidget(title: Labels.areaId, order: 1),
        PhotoCommentForm(
            order: 2,
            title: Labels.incidentDocumentation,
            hasChanges: (data) {
              setState(() {
                _negativeAspects.add(data);
              });
            }),
      ],
      pageStart: number,
    );
  }

  openWidget(Widget input) {
    handleBottomFooter(true);
    var bottomSheetController = _scaffoldstate.currentState.showBottomSheet(
      (context) => input,
      clipBehavior: Clip.hardEdge,
    );
    bottomSheetController.closed.then((value) => handleBottomFooter(false));
  }

  handleBottomFooter(bool value) {
    setState(() {
      isFormOpened = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    String title;
    checkRoute() {
      Map<String, String> routPathList = CurrentPath().get();
      String route = ModalRoute.of(context).settings.name;
      title = routPathList.keys
          .firstWhere((k) => routPathList[k] == route, orElse: () => null);
    }

    checkRoute();
    return Scaffold(
      key: _scaffoldstate,
      appBar: AppBar(
        title: Text(dinamicTitles[title]),
      ),
      body: ListView(children: <Widget>[
        AuditListElement(
          title: Labels.areaId,
          order: 1,
          subtitle: test,
          isDone: test != null,
          onTap: () {
            openWidget(getNav(0));
          },
        ),
        DropDownAuditListElement(
          title: Labels.incidentDocumentation,
          order: 2,
          isDone: _negativeAspects.length != 0,
          aspects: _negativeAspects,
          onTap: () {
            openWidget(getNav(1));
          },
        ),
        AuditListElement(
          title: Labels.selectGravitty,
          order: 3,
          subtitle: test,
          isDone: test != null,
          trailing: Text(
            inputList[stepValue],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          onTap: () {},
        ),
        EhsSlider(
          inputList: inputList,
          step: stepValue,
          getValue: (value) {
            setState(() {
              stepValue = value.toInt();
            });
          },
        ),
      ]),
      bottomNavigationBar: isFormOpened
          ? null
          : BottomAppBar(
              color: AppColors.primary,
              child: SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                    child: Text(Labels.save),
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                  ))),
    );
  }
}
