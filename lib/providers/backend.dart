import 'dart:convert';

import 'package:pats4u/models/class.dart';
import 'package:pats4u/models/staff_member.dart';
import 'package:pats4u/providers/staff_cache_manager.dart';

class Backend {
  static const String baseURL = 'http://noahs-macbook-pro.local:3000';

  static Future<List<StaffMember>> getStaffMembers({bool force = false}) async {
    if ( force ) {
      await StaffCacheManager().emptyCache();
    }
    return StaffCacheManager().getSingleFile(baseURL + '/staff/all').then((value) async {
      if ( await value.exists() ) {
        var res = await value.readAsString();
        return (json.decode(res) as List).map((s) => StaffMember.fromJson(s)).toList();
      } else {
        return [];
      }
    });
  }

  static Future<List<Class>> getClasses() {
    return StaffCacheManager().getSingleFile(baseURL + '/class/all').then((value) async {
      if ( await value.exists() ) {
        var res = await value.readAsString();
        return (json.decode(res) as List).map((s) => Class.fromJson(s)).toList();
      } else {
        return [];
      }
    });
  }
}