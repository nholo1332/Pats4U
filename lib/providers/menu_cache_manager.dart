import 'package:flutter_cache_manager/flutter_cache_manager.dart';

// Create an instance of the cache manager for the Menu data
class MenuCacheManager extends CacheManager {
  static const key = 'menuCache';
  static const Duration cacheTimeout = Duration(days: 5);

  MenuCacheManager()
      : super(
          Config(
            key,
            stalePeriod: cacheTimeout,
            maxNrOfCacheObjects: 25,
            fileService: HttpFileService(),
          ),
        );
}
