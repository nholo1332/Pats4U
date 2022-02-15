import 'package:package_info_plus/package_info_plus.dart';
import 'package:pats4u/models/user.dart';

class Constants {

  static User userData = User();
  static PackageInfo? packageInfo;

  init() {
    userData = User();
  }

}