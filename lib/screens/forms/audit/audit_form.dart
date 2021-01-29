import 'package:ehsfocus/models/action/audit_head_modal.dart';
import 'package:ehsfocus/models/action/audit_model.dart';
import 'package:ehsfocus/models/aspect/aspects_model.dart';
import 'package:ehsfocus/screens/forms/area/area_form.dart';
import 'package:ehsfocus/bloc/area/area_bloc.dart';
import 'package:ehsfocus/screens/forms/aspects/aspects.dart';
import 'package:ehsfocus/bloc/audit_bloc/audit_bloc_index.dart';
import 'package:ehsfocus/screens/forms/shared_form_components/audit_list_element.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/form_eleements/form_footer.dart';
import 'package:ehsfocus/shared/loading.dart';
import 'package:ehsfocus/shared/navigation_form/navigation_wrapper.dart';
import 'package:ehsfocus/theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuditForm extends StatefulWidget {
  final bool loadDataFromList;

  const AuditForm({Key key, this.loadDataFromList}) : super(key: key);
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
  String areaSubtitle;
  String pageType;
  Audit formData = Audit();
  bool _hasData = false;
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

    _hasData =
        widget.loadDataFromList == null ? false : widget.loadDataFromList;
    if (!_hasData) {
      BlocProvider.of<AuditBloc>(context).getAudit();
    }
  }

  Widget getNav(int number, context) {
    return BlocProvider(
      create: (context) {
        AreaBloc areaBloc = AreaBloc();
        if (area != null) {
          areaBloc.setareaString(area.area);
        }
        return areaBloc;
      },
      child: EhsNavigatorWidget(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldstate,
      appBar: _hasData
          ? null
          : AppBar(
              title: Text(Labels.auditTitle),
            ),
      // maybe can bereoved
      body: BlocListener<AuditBloc, AuditState>(
        listener: (BuildContext context, AuditState state) {},
        child: BlocBuilder<AuditBloc, AuditState>(
          builder: (BuildContext context, state) {
            if (state is AuditDataState) {
              area = state.audit.auditHead;
              areaTitle = area != null ? '${area.area}' : null;
              areaSubtitle =
                  area != null ? 'audit de: ${area.auditType}' : null;
              _negativeAspects = state.audit.negativeAspects ?? [];
              _positiveAspects = state.audit.positiveAspects ?? [];
            }
            if (state is DeleteSucsesfull) {
              area = null;
              areaTitle = null;
              areaSubtitle = null;
              _negativeAspects = [];
              _positiveAspects = [];
            }
            return ListView(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                AuditListElement(
                  title: areaTitle == null ? Labels.areaId : areaTitle,
                  order: 1,
                  subtitle: areaSubtitle,
                  isDone: areaTitle != null,
                  onTap: () {
                    openWidget(getNav(0, context));
                  },
                ),
                DropDownAuditListElement(
                  disabled: area == null,
                  title: Labels.positiveAcctionMessage,
                  order: 2,
                  isDone: _positiveAspects.length != 0,
                  aspects: _positiveAspects,
                  selected: (data) {},
                  onTap: () {
                    openWidget(getNav(1, context));
                  },
                ),
                DropDownAuditListElement(
                  disabled: area == null,
                  title: Labels.negativeAcctionMessage,
                  order: 3,
                  isDone: _negativeAspects.length != 0,
                  aspects: _negativeAspects,
                  onTap: () {
                    openWidget(getNav(2, context));
                  },
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: isFormOpened
          ? null
          : BlocBuilder<AuditBloc, AuditState>(
              builder: (context, state) {
                if (state is AuditLoading) {
                  return Loading(
                    color: AppColors.transparent,
                    size: 30,
                  );
                }
                return FormFooter(
                  isEditable: false,
                  actions: [Labels.delete, Labels.save, Labels.send],
                  action: (action) {
                    switch (action) {
                      case Labels.delete:
                        // TODO add popup
                        BlocProvider.of<AuditBloc>(context)
                            .deleteAuidit(area.id);
                        break;
                      case Labels.save:
                        BlocProvider.of<AuditBloc>(context).setAudit();

                        break;
                      case Labels.send:
                        BlocProvider.of<AuditBloc>(context).submitAudit();
                        break;
                    }
                  },
                );
              },
            ),
    );
  }
}
