class EhsStoreSingleton {
  EhsStoreSingleton._privateConstructor();

  static final EhsStoreSingleton _instance =
      EhsStoreSingleton._privateConstructor();

  factory EhsStoreSingleton() {
    return _instance;
  }
  String data;
  updateStore(datain) {
    data = datain;
    print(data);
  }

  retriveData() {
    print('here');
    print(data);
  }

  retriveFromStore() {}
}
