import 'package:flutter_cache_manager/flutter_cache_manager.dart';

// Create an instance of the cache manager for the Classes data
class ClassesCacheManager extends CacheManager {
  static const key = 'classesCache';
  static const Duration cacheTimeout = Duration(days: 15);

  ClassesCacheManager()
      : super(
          Config(
            key,
            stalePeriod: cacheTimeout,
            maxNrOfCacheObjects: 5,
            fileService: HttpFileService(),
          ),
        );
}
