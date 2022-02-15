import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class StaffCacheManager extends CacheManager {
  static const key = 'staffCache';
  static const Duration cacheTimeout = Duration(days: 15);

  StaffCacheManager()
      : super(
          Config(
            key,
            stalePeriod: cacheTimeout,
            maxNrOfCacheObjects: 5,
            fileService: HttpFileService(),
          ),
        );
}
