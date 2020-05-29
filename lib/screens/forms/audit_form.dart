import 'package:ehsfocus/models/action_model.dart';
import 'package:ehsfocus/models/area_model.dart';
import 'package:ehsfocus/models/aspects_model.dart';
import 'package:ehsfocus/screens/aspects/aspects.dart';
import 'package:ehsfocus/screens/forms/area_form.dart';
import 'package:ehsfocus/screens/forms/shared_form_components/audit_list-element.dart';
import 'package:ehsfocus/services/page_helper_service.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/navigation_form/navigation_wrapper.dart';
import 'package:ehsfocus/state/audit_bloc/audit_bloc.dart';
import 'package:ehsfocus/state/audit_bloc/audit_bloc_index.dart';

import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuditForm extends StatefulWidget {
  @override
  _AuditFormState createState() => _AuditFormState();
}

class _AuditFormState extends State<AuditForm> {
  final GlobalKey<ScaffoldState> _scaffoldstate = GlobalKey<ScaffoldState>();
  bool isFormOpened = false;
  List<Aspect> _negativeAspects = [];
  List<Aspect> _positiveAspects = [];
  Area area;
  String test;

  Audit formData = Audit();

  openWidget(Widget input) {
    handleBottomFooter(true);
    PersistentBottomSheetController bottomSheetController =
        _scaffoldstate.currentState.showBottomSheet(
      (context) => input,
      clipBehavior: Clip.hardEdge,
    );
    print(bottomSheetController);
    bottomSheetController.closed.then((value) {
      handleBottomFooter(false);
      print(bottomSheetController);
    });
  }

  handleBottomFooter(bool value) {
    setState(() {
      isFormOpened = value;
    });
  }

  Widget getNav(int number) {
    return EhsNavigatorWidget(
      displayWidgets: [
        AreaFromWidget(
          title: Lables.areaId,
          order: 1,
          area: area,
          getData: (data) {
              BlocProvider.of<AuditBloc>(context).setArea(data);
          },
           
        ),
        AspectsList(
          aspects: _positiveAspects,
          order: 2,
          type: 'P',
          title: Lables.positiveAcctionMessage,
          hasChanges: (data) {
            if (data == null) {
              return;
            }
            setState(() {
              _positiveAspects = data;
            });
          },
        ),
        AspectsList(
            aspects: _negativeAspects,
            order: 3,
            type: 'N',
            title: Lables.negativeAcctionMessage,
            hasChanges: (data) {
              if (data == null) {
                return;
              }
              setState(() {
                _negativeAspects = data;
              });
            }),
      ],
      pageStart: number,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldstate,
      appBar: AppBar(
        title: Text(PageHelperService().checkRoute(context)),
      ),
      body:
      //  BlocProvider<AuditBloc>(
      //   create: (BuildContext context) => AuditBloc(),
      //   child:
        
         BlocListener<AuditBloc, AuditState>(
          listener: (BuildContext context, AuditState state){
            if (state is AuditDataState) {
              print(state);
                area = state.audit.area;
               test = '${area.area}-${area.step}';
              }
              },
          child:
           BlocBuilder<AuditBloc, AuditState>(
            builder: (BuildContext context, state) => 
            ListView(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                AuditListElement(
                  title: Lables.areaId,
                  order: 1,
                  subtitle: test,
                  isDone: test != null,
                  onTap: () {
                    openWidget(getNav(0));
                  },
                ),
                DropDownAuditListElement(
                  title: Lables.positiveAcctionMessage,
                  order: 2,
                  isDone: _positiveAspects.length != 0,
                  aspects: _positiveAspects,
                  selected: (data) {},
                  onTap: () {
                    openWidget(getNav(1));
                  },
                ),
                DropDownAuditListElement(
                  title: Lables.negativeAcctionMessage,
                  order: 3,
                  isDone: _negativeAspects.length != 0,
                  aspects: _negativeAspects,
                  onTap: () {
                    openWidget(getNav(2));
                  },
                ),
              ],
            ),
          ),
        // ),
      ),
      bottomNavigationBar: isFormOpened
          ? null
          : BottomAppBar(
              color: AppColors.primary,
              child: SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                    child: Text(Lables.save),
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                  ))),
    );
  }
}
