import 'package:hive_flutter/hive_flutter.dart';

enum HiveBoxKeys { cart, product, favorite }

class HiveServices {
  static final HiveServices _instance = HiveServices._internal();
  factory HiveServices() => _instance;
  HiveServices._internal();

  final Map<HiveBoxKeys, Box> _boxes = {};

  Future<void> init() async {
    await Hive.initFlutter();
  }

  Future<Box> getBox(HiveBoxKeys boxKey) async {
    if (_boxes.containsKey(boxKey)) {
      return _boxes[boxKey]!;
    }

    final box = await Hive.openBox(boxKey.name);
    _boxes[boxKey] = box;
    return box;
  }

  Future<void> saveData<T>({
    required HiveBoxKeys boxKey,
    required String key,
    required T value,
  }) async {
    try {
      final box = await getBox(boxKey);
      await box.put(key, value);
    } catch (e) {
      throw Exception('Failed to save data: $e');
    }
  }

  Future<T?> getData<T>({
    required HiveBoxKeys boxKey,
    required String key,
  }) async {
    try {
      final box = await getBox(boxKey);
      return box.get(key);
    } catch (e) {
      throw Exception('Failed to get data: $e');
    }
  }

  Future<Map<dynamic, dynamic>> getAllData({
    required HiveBoxKeys boxKey,
  }) async {
    try {
      final box = await getBox(boxKey);
      return box.toMap();
    } catch (e) {
      throw Exception('Failed to get all data: $e');
    }
  }

  Future<void> deleteData({
    required HiveBoxKeys boxKey,
    required String key,
  }) async {
    try {
      final box = await getBox(boxKey);
      await box.delete(key);
    } catch (e) {
      throw Exception('Failed to delete data: $e');
    }
  }

  Future<void> clearBox({required HiveBoxKeys boxKey}) async {
    try {
      final box = await getBox(boxKey);
      await box.clear();
    } catch (e) {
      throw Exception('Failed to clear box: $e');
    }
  }

  Future<bool> containsKey({
    required HiveBoxKeys boxKey,
    required String key,
  }) async {
    try {
      final box = await getBox(boxKey);
      return box.containsKey(key);
    } catch (e) {
      throw Exception('Failed to check key: $e');
    }
  }

  /// Close a specific box
  Future<void> closeBox(HiveBoxKeys boxKey) async {
    if (_boxes.containsKey(boxKey)) {
      await _boxes[boxKey]?.close();
      _boxes.remove(boxKey);
    }
  }

  Future<void> closeAllBoxes() async {
    for (var box in _boxes.values) {
      await box.close();
    }
    _boxes.clear();
  }

  Future<int> getBoxLength(HiveBoxKeys boxKey) async {
    final box = await getBox(boxKey);
    return box.length;
  }
}
