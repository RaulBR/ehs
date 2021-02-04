import 'package:ehsfocus/models/employee/employee_model.dart';
import 'package:ehsfocus/services/repository/employee_repo.dart';
import 'package:ehsfocus/services/repository/local_database/area_local_db.dart';
import 'package:ehsfocus/services/repository/local_database/category_local_db.dart';
import 'package:ehsfocus/services/repository/local_database/repo.dart';

import 'package:hive/hive.dart';

EmployeeRepo employeeRepo = EmployeeRepo();
AreaLocalDb _areaLocalDp = AreaLocalDb();
CategoryLocalDb _categoryLocalDb = CategoryLocalDb();

class RepoService {
  clearAllHives() async {
    await employeeRepo.deleteLocaEmployee();
    await _areaLocalDp.deleteAreas();
    await _categoryLocalDb.clearBox();
  }
}
