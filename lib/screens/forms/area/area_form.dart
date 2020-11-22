import 'package:ehsfocus/models/audit_head_modal.dart';
import 'package:ehsfocus/models/generic_list_model.dart';
import 'package:ehsfocus/screens/forms/area/area_providers.dart';
import 'package:ehsfocus/screens/forms/area/bloc/area_bloc.dart';
import 'package:ehsfocus/screens/forms/audit/audit_bloc/audit_bloc.dart';
import 'package:ehsfocus/screens/forms/audit/audit_bloc/audit_bloc_index.dart';
import 'package:ehsfocus/services/qr_scanning.dart';
import 'package:ehsfocus/shared/fields/search_picker/custom_list_search.dart';
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
    String _data;
    _area = area ?? _area;

    return AreaDependencies(
      child: BlocBuilder<AuditBloc, AuditState>(
        builder: (context, auditState) {
          // ignore: close_sinks
          AreaBloc areaBloc = BlocProvider.of<AreaBloc>(context);
          return SingleChildScrollView(
            child: AuditFormWraper(
              title: Labels.areaId,
              order: order,
              children: [
                SizedBox(
                  height: 40,
                ),
                BlocBuilder<AreaBloc, AreaState>(
                  buildWhen: (previous, current) => current is AreaListState,
                  builder: (context, state) => EhsSearchListPicker(
                    label: Labels.area1,
                    list: state is AreaListState
                        ? state.areaList
                            .map((element) => GenericListObject(
                                id: element.id, title: element.area ?? null))
                            .toList()
                        : [],
                    preselected: area != null ? area.area : null,
                    selected: (data) {
                      _area.step = data == _area.area ? _area.step : null;
                      _area.area = data.title;
                      getData(_area);
                      BlocProvider.of<AuditBloc>(context).setArea(_area);
                    },
                    tapped: () {
                      areaBloc.getAreas();
                    },
                    searchFor: (data) {
                      areaBloc.searchAreas(data);
                    },
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                FlatButton(
                  onPressed: () async {
                    _data = await scan.scanQr();
                    try {
                      _area = AuditHead.fromJson(json.decode(_data));
                      BlocProvider.of<AuditBloc>(context).setArea(_area);
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
              ],
            ),
          );
        },
      ),
    );
  }
}
