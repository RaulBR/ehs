import 'package:ehsfocus/models/audit_head_modal.dart';
import 'package:ehsfocus/screens/category/category_type_picker.dart';
import 'package:ehsfocus/screens/forms/area/are_dropdown_picker.dart';
import 'package:ehsfocus/screens/forms/area/bloc/area_bloc.dart';
import 'package:ehsfocus/screens/forms/audit/audit_bloc/audit_bloc_index.dart';

import 'package:ehsfocus/services/qr_scanning.dart';

import 'package:ehsfocus/shared/form_eleements/audit_form_wraper.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

class AreaFromWidget extends StatelessWidget {
  final AuditHead area;
  final String title;
  final Function getData;
  final int order;

  AreaFromWidget({this.title, this.getData, this.order, this.area});

  @override
  Widget build(BuildContext context) {
    QrScanService scan = QrScanService();
    AuditHead _area = AuditHead();
    AuditHead error = AuditHead();
    _area = area ?? _area;

    var children = [
      SizedBox(
        height: 40,
      ),
      BlocBuilder<AuditBloc, AuditState>(
        builder: (context, state) {
          if (state is AuditDataState) {
            _area = state.audit.auditHead;
          }
          return AreaDropDownPiker(
            area: _area,
            getData: (data) {
              getData(data);
              BlocProvider.of<AreaBloc>(context).setAreaFormByArea(data);
            },
          );
        },
      ),
      CategoryTypePiker(
        error: error == null ? null : error.auditType,
        input: _area.auditType,
        isEditable: true,
        hasChanges: (_categoryType) {
          _area.auditType = _categoryType;
        },
        label: Labels.aspectType,
      ),
      SizedBox(
        height: 50,
      ),
      FlatButton(
        onPressed: () async {
          try {
            _area = AuditHead.fromJson(json.decode(await scan.scanQr()));
            getData(_area);
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
