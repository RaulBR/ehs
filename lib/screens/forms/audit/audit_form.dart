import 'package:ehsfocus/models/action_model.dart';
import 'package:ehsfocus/models/audit_head_modal.dart';
import 'package:ehsfocus/models/aspects_model.dart';
import 'package:ehsfocus/screens/forms/area/area_form.dart';
import 'package:ehsfocus/screens/forms/aspects/aspects.dart';
import 'package:ehsfocus/screens/forms/audit/audit_bloc/audit_bloc_index.dart';
import 'package:ehsfocus/screens/forms/shared_form_components/audit_list_element.dart';
import 'package:ehsfocus/services/page_helper_service.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/form_eleements/form_footer.dart';
import 'package:ehsfocus/shared/navigation_form/navigation_wrapper.dart';

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
  AuditHead area = AuditHead();
  String areaTitle;
  String pageType;
  Audit formData = Audit();

  openWidget(Widget input) {
    handleBottomFooter(true);
    PersistentBottomSheetController bottomSheetController =
        _scaffoldstate.currentState.showBottomSheet(
      (context) => input,
      clipBehavior: Clip.hardEdge,
    );

    bottomSheetController.closed.then((value) {
      handleBottomFooter(false);
    });
  }

  handleBottomFooter(bool value) {
    setState(() {
      isFormOpened = value;
    });
  }

  void initState() {
    super.initState();
    BlocProvider.of<AuditBloc>(context).getAudit();
  }

  Widget getNav(int number, context) {
    return EhsNavigatorWidget(
      action: (data) {
        if (data == 0) {
          BlocProvider.of<AuditBloc>(context).setAudit();
        }
      },
      displayWidgets: [
        AreaFromWidget(
          title: Labels.areaId,
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
          title: Labels.positiveAcctionMessage,
          hasChanges: (data) {
            if (data == null) {
              return;
            }
            BlocProvider.of<AuditBloc>(context).setAspect(data);
          },
        ),
        AspectsList(
            aspects: _negativeAspects,
            order: 3,
            type: 'N',
            title: Labels.negativeAcctionMessage,
            hasChanges: (data) {
              if (data == null) {
                return;
              }
              BlocProvider.of<AuditBloc>(context).setAspect(data);
            }),
      ],
      pageStart: number,
    );
  }

  @override
  Widget build(BuildContext context) {
    PageHelperService pageService = PageHelperService(context: context);
    return Scaffold(
      key: _scaffoldstate,
      appBar: AppBar(
        title: Text(pageService.checkRoute()),
      ),
      body: BlocListener<AuditBloc, AuditState>(
        listener: (BuildContext context, AuditState state) {
          if (state is AuditDataState) {
            if (state.audit.auditHead != null) {
              area = state.audit.auditHead;
              areaTitle = '${area.area}';
              _negativeAspects = state.audit.negativeAspects ?? [];
              _positiveAspects = state.audit.positiveAspects ?? [];
            }
          }
          if (state is DeleteSucsesfull) {
            area = null;
            areaTitle = null;
            _negativeAspects = [];
            _positiveAspects = [];
          }
        },
        child: BlocBuilder<AuditBloc, AuditState>(
          builder: (BuildContext context, state) => ListView(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              AuditListElement(
                title: Labels.areaId,
                order: 1,
                subtitle: areaTitle,
                isDone: areaTitle != null,
                onTap: () {
                  openWidget(getNav(0, context));
                },
              ),
              DropDownAuditListElement(
                title: Labels.positiveAcctionMessage,
                order: 2,
                isDone: _positiveAspects.length != 0,
                aspects: _positiveAspects,
                selected: (data) {
                  // TODO add navigate to page
                },
                onTap: () {
                  // TODO add navigate to page
                  openWidget(getNav(1, context));
                },
              ),
              DropDownAuditListElement(
                title: Labels.negativeAcctionMessage,
                order: 3,
                isDone: _negativeAspects.length != 0,
                aspects: _negativeAspects,
                onTap: () {
                  openWidget(getNav(2, context));
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: isFormOpened
          ? null
          : FormFooter(
              actions: [
                FooterStates.delete,
                FooterStates.save,
                FooterStates.send
              ],
              action: (action) {
                // TODO move to bloc
                switch (action) {
                  case FooterStates.delete:
                    // TODO add popup
                    BlocProvider.of<AuditBloc>(context).deleteAuidit(area.id);
                    break;
                  case FooterStates.save:
                    BlocProvider.of<AuditBloc>(context).setAudit();

                    break;
                  case FooterStates.send:
                    BlocProvider.of<AuditBloc>(context).submitAudit();

                    break;
                }
              },
            ),
    );
  }
}
