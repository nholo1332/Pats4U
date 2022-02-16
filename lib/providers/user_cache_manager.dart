import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pats4u/providers/constants.dart';

// Create an instance of the cache manager for the User data
class UserCacheManager extends CacheManager {
  static const key = 'userCache';
  static const Duration cacheTimeout = Duration(days: 1);

  UserCacheManager()
      : super(
          Config(
            key,
            stalePeriod: cacheTimeout,
            maxNrOfCacheObjects: 2,
            fileService: HttpFileService(),
          ),
        );

  static resetUser() {
    Constants().init();
  }
}
