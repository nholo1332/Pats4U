import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class FeedCacheManager extends CacheManager {
  static const key = 'feedCache';
  static const Duration cacheTimeout = Duration(days: 2);

  FeedCacheManager()
      : super(
    Config(
      key,
      stalePeriod: cacheTimeout,
      maxNrOfCacheObjects: 8,
      fileService: HttpFileService(),
    ),
  );
}
