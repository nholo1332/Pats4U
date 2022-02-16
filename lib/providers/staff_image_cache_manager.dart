import 'package:flutter_cache_manager/flutter_cache_manager.dart';

// Create an instance of the cache manager for the Staff images
class StaffImageCacheManager extends CacheManager {
  static const key = 'staffImageCache';
  static const Duration cacheTimeout = Duration(days: 30);

  StaffImageCacheManager()
      : super(
          Config(
            key,
            stalePeriod: cacheTimeout,
            maxNrOfCacheObjects: 100,
          ),
        );
}
