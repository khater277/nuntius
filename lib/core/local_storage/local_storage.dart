abstract class LocalStorage<Type> {
  Future<void> init();
  String key();
  bool hasData();
  Future<void> saveData({required Type? data});
  Type? getData();
  List<Type> getAllData();
  Future<void> delete();
}
