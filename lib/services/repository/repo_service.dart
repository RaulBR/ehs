import 'package:ehsfocus/services/repository/local_database/repo.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:hive/hive.dart';

class RepoService extends HiveRepo {
  clearAllHives() {
    HiveName()
        .toListElements()
        .forEach((element) => Hive.openBox(element).then((box) => box.clear()));
  }
}
