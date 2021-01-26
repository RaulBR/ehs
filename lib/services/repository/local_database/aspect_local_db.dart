import 'package:ehsfocus/models/aspect/aspects_model.dart';
import 'package:ehsfocus/services/repository/local_database/repo.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:hive/hive.dart';

class AspectLocaldb extends HiveRepo {
  Future<void> addToUpdateQueue(Aspect aspect) async {
    if (aspect.id == null) {
      return;
    }
    Box<Aspect> aspectBox = await initiateBox(HiveName.aspectUpdate);
    aspectBox.put(aspect.id, aspect);
    aspectBox.close();
  }

  Future<void> addToDelete(Aspect aspect) async {
    if (aspect.id == null) {
      return;
    }
    Box<Aspect> aspectBox = await initiateBox(HiveName.aspectDelete);
    aspectBox.put(aspect.id, aspect);
    aspectBox.close();
  }

  Future<List<Aspect>> getDeleteAspects() async {
    return await _getHiveListItem(HiveName.aspectDelete);
  }

  Future<List<Aspect>> getUpdateAspects() async {
    return await _getHiveListItem(HiveName.aspectUpdate);
  }

  Future<List<Aspect>> _getHiveListItem(String hiveName) async {
    if (hiveName == null) return [];
    Box<Aspect> aspectsBox = await initiateBox(hiveName);
    List<Aspect> aspects = aspectsBox.values as List<Aspect>;
    aspectsBox.close();
    return aspects == null ? [] : aspects;
  }

  clearQuese() async {
    Box<Aspect> aspecDeletetBox = await initiateBox(HiveName.aspectDelete);
    Box<Aspect> aspectUpdateBox = await initiateBox(HiveName.aspectUpdate);

    await aspecDeletetBox.clear();
    await aspectUpdateBox.clear();

    aspecDeletetBox.close();
    aspectUpdateBox.close();
  }
}
