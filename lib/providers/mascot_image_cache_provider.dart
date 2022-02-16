import 'package:flutter_cache_manager/flutter_cache_manager.dart';

// Create an instance of the cache manager for the Mascot images (feed view)
class MascotImageCacheManager extends CacheManager {
  static const key = 'mascotImageCache';
  static const Duration cacheTimeout = Duration(days: 30);

  MascotImageCacheManager()
      : super(
    Config(
      key,
      stalePeriod: cacheTimeout,
      maxNrOfCacheObjects: 40,
    ),
  );
}
