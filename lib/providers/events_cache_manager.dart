import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class EventsCacheManager extends CacheManager {
  static const key = 'eventsCache';
  static const Duration cacheTimeout = Duration(days: 1);

  EventsCacheManager()
      : super(
          Config(
            key,
            stalePeriod: cacheTimeout,
            maxNrOfCacheObjects: 15,
            fileService: HttpFileService(),
          ),
        );
}
