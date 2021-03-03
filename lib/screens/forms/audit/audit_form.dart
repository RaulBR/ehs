import 'package:ehsfocus/models/action/audit_head_modal.dart';
import 'package:ehsfocus/models/aspect/aspects_model.dart';
import 'package:ehsfocus/bloc/area/area_bloc.dart';
import 'package:ehsfocus/bloc/audit_bloc/audit_bloc_index.dart';
import 'package:ehsfocus/models/form_metadata.dart/form_footer_model.dart';
import 'package:ehsfocus/screens/forms/audit/audit_service.dart';
import 'package:ehsfocus/screens/forms/shared_form_components/audit_list_element.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/form_eleements/form_footer.dart';
import 'package:ehsfocus/shared/loading.dart';
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
  final _auditService = AuditService();
  bool isFormOpened = false;
  List<Aspect> _negativeAspects = [];
  List<Aspect> _positiveAspects = [];
  AuditHead _area = AuditHead();

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
      body: BlocBuilder<AuditBloc, AuditState>(
        buildWhen: (previous, current) => current is AuditDataState,
        builder: (BuildContext context, state) {
          String areaTitle;
          String areaSubtitle;
          if (state is AuditDataState) {
            _area = state.audit.auditHead;
            areaTitle = _auditService.getAreaTitle(state.audit);
            areaSubtitle = _auditService.getAreaSubTitle(state.audit);
            _negativeAspects = state.audit.negativeAspects ?? [];
            _positiveAspects = state.audit.positiveAspects ?? [];
          }
          if (state is DeleteSucsesfull) {
            _area = null;
            areaTitle = null;
            areaSubtitle = null;
            _negativeAspects = [];
            _positiveAspects = [];
          }
          if (_area != null) {
            BlocProvider.of<AreaBloc>(context).setareaString(_area.area);
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
                  openWidget(_auditService.getNav(0, context));
                },
              ),
              DropDownAuditListElement(
                disabled: _area == null,
                title: Labels.positiveAcctionMessage,
                order: 2,
                isDone: _positiveAspects.length != 0,
                aspects: _positiveAspects,
                selected: (data) {},
                onTap: () {
                  openWidget(_auditService.getNav(1, context));
                },
              ),
              DropDownAuditListElement(
                disabled: _area == null,
                title: Labels.negativeAcctionMessage,
                order: 3,
                isDone: _negativeAspects.length != 0,
                aspects: _negativeAspects,
                onTap: () {
                  openWidget(_auditService.getNav(2, context));
                },
              ),
            ],
          );
        },
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
                  actions: [
                    FormFooterModel(Labels.delete, editable: true),
                    FormFooterModel(Labels.save, editable: true),
                    FormFooterModel(Labels.send, editable: true)
                  ],
                  action: (action) {
                    switch (action) {
                      case Labels.delete:
                        // TODO add popup
                        BlocProvider.of<AuditBloc>(context)
                            .deleteAuidit(_area.id);
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
