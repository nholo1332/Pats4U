import 'package:flutter_cache_manager/flutter_cache_manager.dart';

// Create an instance of the cache manager for the Mascot images (feed view)
class FeedImageCacheManager extends CacheManager {
  static const key = 'feedImageCache';
  static const Duration cacheTimeout = Duration(days: 30);

  FeedImageCacheManager()
      : super(
    Config(
      key,
      stalePeriod: cacheTimeout,
      maxNrOfCacheObjects: 40,
    ),
  );
}
