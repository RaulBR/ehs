import 'package:ehsfocus/models/action/audit_head_modal.dart';

import 'package:ehsfocus/screens/category/category_type_picker.dart';
import 'package:ehsfocus/screens/forms/area/area_dropdown_picker.dart';
import 'package:ehsfocus/bloc/area/area_bloc.dart';
import 'package:ehsfocus/bloc/audit_bloc/audit_bloc_index.dart';

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
    _area = area == null ? _area : area;

    var children = [
      SizedBox(
        height: 40,
      ),
      BlocBuilder<AuditBloc, AuditState>(
        builder: (context, state) {
          if (state is AuditDataState) {
            _area = state.audit.auditHead == null
                ? AuditHead()
                : state.audit.auditHead;
          }
          return AreaDropDownPiker(
            area: _area,
            getData: (data) {
              _area.area = data.area;
              BlocProvider.of<AreaBloc>(context).updatFormByString(_area.area);
              getData(_area);
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
          getData(_area);
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
