import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {

  /// 存数据
  /// SharedPreferencesUtils.savePreference(context, key, value);
  static Object savePreference(BuildContext context, String key,
      Object value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    } else if (value is List) {
      await prefs.setStringList(key, value);
    } else {
      throw new Exception("不能得到这种类型");
    }
  }

  /// 取数据
  /// func: ()async{
  /// Type m = await (SharedPreferencesUtils.getPreference
  /// (context, key, defaultValue)) as Type ;
  /// },
  static Future getPreference(Object context, String key,
      Object defaultValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (defaultValue is int) {
      if (prefs.getString(key) == null){
        await prefs.setInt(key, defaultValue);
        return defaultValue;
      }
      return prefs.getInt(key);
    }
    else if (defaultValue is double) {
      if (prefs.getString(key) == null){
        await prefs.setDouble(key, defaultValue);
        return defaultValue;
      }
      return prefs.getDouble(key);
    }
    else if (defaultValue is bool) {
      if (prefs.getString(key) == null){
        await prefs.setBool(key, defaultValue);
        return defaultValue;
      }
      return prefs.getBool(key);
    }
    else if (defaultValue is String) {
      if (prefs.getString(key) == null){
        await prefs.setString(key, defaultValue);
        return defaultValue;
      }
      return prefs.getString(key);
    }
    else if (defaultValue is List) {
      if (prefs.getString(key) == null){
        await prefs.setStringList(key, defaultValue);
        return defaultValue;
      }
      return prefs.getStringList(key);
    }
    else {
      throw new Exception("不能得到这种类型");
    }
  }

  /// 删除指定数据
  /// SharedPreferencesUtils.remove(key);
  static void remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key); //删除指定键
  }

  /// 清空整个缓存
  /// SharedPreferencesUtils.clear();
  static void clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear(); ////清空缓存
  }
}