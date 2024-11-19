import 'package:flutter_application/pages/custom.dart';
import 'package:flutter_application/pages/home.dart';
import 'package:flutter_application/pages/list.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter/material.dart';

class Routes {
  /// 主页面
  static String root = '/';
  static String main = '/main';


  /// 启动页面 （ 显示隐私政策的弹框，不同意则无法进入app ）
  static String launch = '/launch';

  /// web页面
  static String webview = '/webview';

  /// 登录页面
  static String login = '/login';

  /// 列表页面
  static String list = '/list';

  /// 自定义组件
  static String custom = '/custom';

  /// arguments 示例 { "showType": 0, "title": "导航栏标题" }
  /// [showType] 0-3 代表显示的车辆类型 0 全部 1 行驶中 2 停止 3 离线
  static String vehicleList = '/user/vehicleList';

  /// 用户基本信息
  static String userInfo = '/user/userInfo';

  /// 修改密码（Native）
  static String changePassword = '/user/changePassword';

  /// 车辆监控（Native）
  static String vehicleMonitor = '/home/vehicleMonitor';

  ///车辆实时监控 (Native)
  static String vehicleActualTimeMonitor = '/home/vehicleActualTimeMonitor';

  /// 行车日志（Native）
  static String driveReport = '/home/driveReport';

  static Map<String, FlutterBoostRouteFactory> routerMap = {
    root: (RouteSettings settings, String? uniqueId) {
      return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return const MyHomePage(title: 'title');
          });
    },
    main: (RouteSettings settings, String? uniqueId) {
      return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return const MyHomePage(title: 'title');
          });
    },
    login: (RouteSettings settings, String? uniqueId) {
      return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return const MyHomePage(title: 'title');
          });
    },
    list: (RouteSettings settings, String? uniqueId) {
      return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return const ListPage();
          });
    },
    custom: (RouteSettings settings, String? uniqueId) {
      return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return const CustomPage();
          });
    },
    vehicleList: (RouteSettings settings, String? uniqueId) {
      return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return const MyHomePage(title: 'title');
          });
    },
    launch: (RouteSettings settings, String? uniqueId) {
      return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return const MyHomePage(title: 'title');
          });
    },
    webview: (RouteSettings settings, String? uniqueId) {
      return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return const MyHomePage(title: 'title');
          });
    },
    userInfo: (RouteSettings settings, String? uniqueId) {
      return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return const MyHomePage(title: 'title');
          });
    },
  };
}
