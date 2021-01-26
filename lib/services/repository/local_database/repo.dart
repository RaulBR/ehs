import 'package:hive/hive.dart';

abstract class HiveRepo {
  Future<Box<T>> initiateBox<T>(hiveName) async {
    Box<T> box;

    if (hiveName == null) {
      return null;
    }
    print(Hive.isBoxOpen(hiveName));
    if (!Hive.isBoxOpen(hiveName)) {
      box = await Hive.openBox(hiveName);
    } else {
      box = Hive.box(hiveName);
    }
    return box;
  }

  void closeBox<T>(hiveName) async {
    Box<T> box;
    if (hiveName == null) {
      return;
    }
    if (Hive.isBoxOpen(hiveName)) {
      box = Hive.box(hiveName);
      box.close();
    }
  }

  Box<T> getbox<T>(hiveName) {
    if (hiveName == null) {
      return null;
    }
    if (Hive.isBoxOpen(hiveName)) {
      return Hive.box<T>(hiveName);
    }
    return null;
  }

  List<T> convertBoxToList<T>(Box box) {
    List<T> list = [];
    if (box == null) {
      return [];
    }
    if (box.length <= 0) {
      return [];
    }
    for (int i = 0; i < box.length; i++) {
      list.add(box.getAt(i));
    }
    return list;
  }

  // clearBox() {

  // }
  closeAll() {
    Hive.close();
  }
}
