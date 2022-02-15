import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class MenuImageCacheManager extends CacheManager {
  static const key = 'menuImageCache';
  static const Duration cacheTimeout = Duration(days: 30);

  MenuImageCacheManager()
      : super(
    Config(
      key,
      stalePeriod: cacheTimeout,
      maxNrOfCacheObjects: 100,
    ),
  );
}
