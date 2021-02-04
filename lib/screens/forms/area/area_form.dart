import 'package:ehsfocus/models/action/audit_head_modal.dart';
import 'package:ehsfocus/screens/category/category_type_picker.dart';
import 'package:ehsfocus/screens/forms/area/area_dropdown_picker.dart';
import 'package:ehsfocus/bloc/audit_bloc/audit_bloc_index.dart';
import 'package:ehsfocus/services/qr_scanning.dart';
import 'package:ehsfocus/shared/form_eleements/audit_form_wraper.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

class AuditHeadForm extends StatelessWidget {
  final String title;
  final int order;

  AuditHeadForm({this.title, this.order});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuditBloc>(context).getAuditHead();
    QrScanService scan = QrScanService();
    AuditHead _area = AuditHead();
    AuditHead error = AuditHead();

    var children = [
      SizedBox(
        height: 40,
      ),
      BlocBuilder<AuditBloc, AuditState>(
        buildWhen: (previous, current) => current is AduitHeadState,
        builder: (context, state) {
          if (state is AduitHeadState) {
            _area = state.auditHead == null ? AuditHead() : state.auditHead;
          }
          return AreaDropDownPiker(
            area: _area,
            getData: (data) {
              _area.area = data._area;
              BlocProvider.of<AuditBloc>(context).setArea(_area);
            },
          );
        },
      ),
      BlocBuilder<AuditBloc, AuditState>(
        buildWhen: (previous, current) => current is AduitHeadState,
        builder: (context, state) {
          if (state is AduitHeadState) {
            _area = state.auditHead == null ? AuditHead() : state.auditHead;
          }
          return CategoryTypePiker(
            error: error == null ? null : error.auditType,
            input: _area.auditType,
            isEditable: true,
            hasChanges: (_categoryType) {
              _area.auditType = _categoryType;
              BlocProvider.of<AuditBloc>(context).setArea(_area);
            },
            label: Labels.aspectType,
          );
        },
      ),
      SizedBox(
        height: 50,
      ),
      FlatButton(
        onPressed: () async {
          try {
            _area = AuditHead.fromJson(json.decode(await scan.scanQr()));
            BlocProvider.of<AuditBloc>(context).setAreaFromQrCode(_area);
          } catch (e) {
            //TODO add error display
            print(e);
          }
        },
        child: Column(
          children: [
            Image.asset(
              'assets/qr-code.png',
              width: 100,
            ),
            Text(Labels.scan)
          ],
        ),
      ),
    ];
    return SingleChildScrollView(
      child: AuditFormWraper(
        title: Labels.areaId,
        order: order,
        children: children,
      ),
    );
  }
}
