import 'package:flutter_cache_manager/flutter_cache_manager.dart';

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
