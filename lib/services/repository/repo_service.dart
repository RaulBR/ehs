import 'package:ehsfocus/services/repository/employee_repo.dart';
import 'package:ehsfocus/services/repository/local_database/area_local_db.dart';
import 'package:ehsfocus/services/repository/local_database/audit_local_db.dart';
import 'package:ehsfocus/services/repository/local_database/category_local_db.dart';

EmployeeRepo employeeRepo = EmployeeRepo();
AreaLocalDb _areaLocalDp = AreaLocalDb();
CategoryLocalDb _categoryLocalDb = CategoryLocalDb();
AuditLocalDb _auditLocalDb = AuditLocalDb();

class RepoService {
  clearAllHives() async {
    await employeeRepo.deleteLocaEmployee();
    await _areaLocalDp.deleteAreas();
    await _categoryLocalDb.clearBox();
    await _auditLocalDb.clearAudit();
  }
}
