import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pats4u/models/class.dart';
import 'package:pats4u/models/event.dart';
import 'package:pats4u/models/months.dart';
import 'package:pats4u/models/staff_member.dart';
import 'package:pats4u/models/user.dart';
import 'package:pats4u/providers/auth.dart';
import 'package:pats4u/providers/events_cache_manager.dart';
import 'package:pats4u/providers/staff_cache_manager.dart';
import 'package:pats4u/providers/user_cache_manager.dart';

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

  static Future<List<Event>> getMonthEvents(Months month, {int year = 0, bool force = false}) async {
    Map<String, String> headers = {};
    if ( year == 0 ) {
      year = DateTime.now().year;
    }
    if ( force ) {
      await EventsCacheManager().emptyCache();
    }
    await Auth.getToken().then((value) {
      headers = {
        'Authorization': 'Bearer ' + value,
      };
    }).catchError((_) {
      headers = {};
    });
    return EventsCacheManager().getSingleFile(baseURL + '/events/all/' + year.toString() + '/' + month.name, headers: headers, ).then((value) async {
      if ( await value.exists() ) {
        var res = await value.readAsString();
        return (json.decode(res) as List).map((s) => Event.fromJson(s)).toList();
      } else {
        return [];
      }
    });
  }

  static Future<User> getUserData({bool force = false}) async {
    Map<String, String> headers = {};
    if ( force ) {
      await UserCacheManager().emptyCache();
    }
    await Auth.getToken().then((value) {
      headers = {
        'Authorization': 'Bearer ' + value,
      };
    }).catchError((_) {
      headers = {};
    });
    return UserCacheManager().getSingleFile(baseURL + '/user/', headers: headers).then((value) async {
      if ( await value.exists() ) {
        var res = await value.readAsString();
        return User.fromJson(jsonDecode(res));
      } else {
        return User();
      }
    });
  }

  static Future<User> registerAccount(String name) async {
    await UserCacheManager().emptyCache();
    return Auth.getToken().then((token) {
      return Dio().post(
        baseURL + '/user/register',
        data: {
          'name': name,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ' + token,
          },
        ),
      );
    }).then((value) {
      return User.fromJson(value.data);
    });
  }

  static Future<String> addEvent(Event event) async {
    await UserCacheManager().emptyCache();
    return Auth.getToken().then((token) {
      return Dio().post(
        baseURL + '/events/add',
        data: jsonEncode(event.toJSON()),
        options: Options(
          headers: {
            'Authorization': 'Bearer ' + token,
          },
        ),
      );
    }).then((value) {
      return value.data['id'] ?? '';
    });
  }
}