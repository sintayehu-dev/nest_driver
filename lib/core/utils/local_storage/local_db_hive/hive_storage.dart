import 'package:hive_flutter/hive_flutter.dart';

/// Reusable Hive storage helper to standardize box management across features.
class HiveStorage {
  HiveStorage._();
  static final HiveStorage instance = HiveStorage._();

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    await Hive.initFlutter();
    _initialized = true;
  }

  /// Opens a typed box, registering the adapter if provided and not already registered.
  Future<Box<T>> openTypedBox<T>(
    String name, {
    TypeAdapter<T>? adapter,
  }) async {
    await init();
    if (adapter != null && !Hive.isAdapterRegistered(adapter.typeId)) {
      Hive.registerAdapter<T>(adapter);
    }
    return Hive.openBox<T>(name);
  }

  bool isAdapterRegistered(int typeId) => Hive.isAdapterRegistered(typeId);

  Future<void> closeBox(String name) async {
    if (Hive.isBoxOpen(name)) {
      await Hive.box(name).close();
    }
  }

  Future<void> closeAll() async {
    await Hive.close();
    _initialized = false;
  }
}

