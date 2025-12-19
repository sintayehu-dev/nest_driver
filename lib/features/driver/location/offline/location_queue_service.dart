import 'dart:async';

import 'package:hive/hive.dart';
import 'package:nest_driver/core/utils/local_storage/local_db_hive/hive_boxes.dart';
import 'package:nest_driver/core/utils/local_storage/local_db_hive/hive_storage.dart';
import 'package:nest_driver/features/driver/location/offline/location_point.dart';

class QueuedLocation {
  QueuedLocation({
    required this.key,
    required this.point,
  });

  final int key;
  final LocationPoint point;
}

class LocationQueueService {
  LocationQueueService._();
  static const _maxStoredPoints = 1000;
  static const _uploadBatchSize = 50;

  static LocationQueueService? _instance;
  static LocationQueueService get instance =>
      _instance ??= LocationQueueService._();

  Box<LocationPoint>? _box;

  bool get isReady => _box?.isOpen ?? false;
  int get uploadBatchSize => _uploadBatchSize;

  Future<void> init() async {
    if (_box?.isOpen ?? false) return;
    _box = await HiveStorage.instance.openTypedBox<LocationPoint>(
      HiveBoxes.locationPoints,
      adapter: LocationPointAdapter(),
    );
  }

  Future<void> enqueue(LocationPoint point) async {
    await _box?.add(point);
    await _trimIfNeeded();
  }

  Future<List<QueuedLocation>> fetchBatch({int? limit}) async {
    final box = _box;
    if (box == null || !box.isOpen || box.isEmpty) return [];

    final keys = box.keys.cast<int>().toList()..sort();
    final batchKeys = keys.take(limit ?? _uploadBatchSize).toList();
    return batchKeys
        .map(
          (k) => QueuedLocation(
            key: k,
            point: box.get(k)!,
          ),
        )
        .toList();
  }

  Future<void> removeBatch(List<int> keys) async {
    final box = _box;
    if (box == null || !box.isOpen || keys.isEmpty) return;
    await box.deleteAll(keys);
  }

  Future<int> count() async => _box?.length ?? 0;

  Future<void> clear() async => _box?.clear();

  Future<void> _trimIfNeeded() async {
    final box = _box;
    if (box == null || !box.isOpen) return;
    var keys = box.keys.cast<int>().toList()..sort();
    if (keys.length <= _maxStoredPoints) return;
    final removeCount = keys.length - _maxStoredPoints;
    final toRemove = keys.take(removeCount).toList();
    await box.deleteAll(toRemove);
  }
}

