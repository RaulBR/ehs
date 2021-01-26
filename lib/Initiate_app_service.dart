import 'package:ehsfocus/models/action/audit_action_model.dart';
import 'package:ehsfocus/models/action/audit_head_modal.dart';
import 'package:ehsfocus/models/action/audit_model.dart';
import 'package:ehsfocus/models/area/area_model.dart';
import 'package:ehsfocus/models/area/area_role_model.dart';
import 'package:ehsfocus/models/area/area_step_model.dart';
import 'package:ehsfocus/models/aspect/aspect_photo.dart';
import 'package:ehsfocus/models/aspect/aspects_model.dart';
import 'package:ehsfocus/models/category/category_model.dart';
import 'package:ehsfocus/models/category/category_type_model.dart';
import 'package:ehsfocus/models/employee/employee_model.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class InitAppService {
  Future<bool> isAppInitiated() async {
    try {
      await Hive.initFlutter();
      initHiveAdaptors();
      return true;
    } catch (e) {
      return false;
    }
  }

  initHiveAdaptors() {
    Hive.registerAdapter(EmployeeAdapter());
    Hive.registerAdapter(CategoryTypeAdapter());
    Hive.registerAdapter(CategoryAdapter());
    Hive.registerAdapter(AreaAdapter());
    Hive.registerAdapter(AreaRoleAdapter());
    Hive.registerAdapter(AreaStepAdapter());
    Hive.registerAdapter(AuditAdapter());
    Hive.registerAdapter(AuditActionAdapter());
    Hive.registerAdapter(AspectPhotoAdapter());
    Hive.registerAdapter(AuditHeadAdapter());

    Hive.registerAdapter(AspectAdapter());
  }

  Future<void> closeRepo() async {
    await Hive.close();
  }
}
