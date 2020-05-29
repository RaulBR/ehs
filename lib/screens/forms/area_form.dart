import 'package:ehsfocus/models/area_model.dart';
import 'package:ehsfocus/services/qr_scanning.dart';
import 'package:ehsfocus/shared/audit_form_wraper.dart';
import 'package:ehsfocus/shared/charts/fields/custom_drop_down.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class AreaFromWidget extends StatelessWidget {
  final Area area;
  final String title;
  final Function getData;
  final int order;

  AreaFromWidget({this.title, this.getData, this.order, this.area});
  
  @override
  Widget build(BuildContext context) {
    QrScanService scan = QrScanService();
    Area _area = Area();
    String _data;
    _area = area ?? _area;
    print('build AreaFromWidget');
    return Scaffold(
      body: AuditFormWraper(
        title: Lables.areaId,
        order: order,
        children: [
          SizedBox(
            height: 40,
          ),
          EhsDropDown(
              label: Lables.area1,
              selected: (data) {
                _area.area = data;
                getData(_area);
              },
              dropDownList: <String>['a', 'b', 'c', 'd'],
              preselected: _area.area == null ? null : '${area.area}'),
          EhsDropDown(
              label: Lables.area2,
              selected: (data) {
                _area.step = data;
                getData(_area);
              },
              dropDownList: <String>['One', 'Two', 'Free', 'Four'],
              preselected: _area.step == null ? null : '${area.step}'),
          SizedBox(
            height: 50,
          ),
          FlatButton(
            onPressed: () async {
              _data = await scan.scanQr();
              try {
                _area = Area.fromJson(json.decode(_data));
                getData(_area);
                print(Area.fromJson(json.decode(_data)).toJson());
              } catch (e) {
                print(e);
              }
            },
            child: Column(
              children: [
                Image.asset(
                  'assets/qr-code.png',
                  width: 100,
                ),
                Text(Lables.scan)
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String data = await QrScanService().scanQr();
          try {
            print(Area.fromJson(json.decode(data)).toJson());
          } catch (e) {
            print(e);
          }
        },
        child: Icon(
          Icons.blur_on,
          size: 40,
        ),
      ),
    );
  }
}
