import 'package:flutter/material.dart';
import 'package:erp_project/screens/splash/splash_screen.dart';
import 'package:erp_project/screens/auth/login_screen.dart';
import 'package:erp_project/screens/dashboard/dashboard_screen.dart';
import 'package:erp_project/screens/inbox/inbox_screen.dart';
import 'package:erp_project/screens/work/work_screen.dart';
import 'package:erp_project/screens/calendar/calendar_screen.dart';
import 'package:erp_project/screens/planner/planner_screen.dart';
import 'package:erp_project/screens/hrm/hrm_screen.dart';
import 'package:erp_project/screens/reports/reports_screen.dart';
import 'package:erp_project/screens/profile/profile_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String inbox = '/inbox';
  static const String work = '/work';
  static const String calendar = '/calendar';
  static const String planner = '/planner';
  static const String hrm = '/hrm';
  static const String reports = '/reports';
  static const String profile = '/profile';

  static final Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginScreen(),
    dashboard: (context) => const DashboardScreen(),
    inbox: (context) => const InboxScreen(),
    work: (context) => const WorkScreen(),
    calendar: (context) => const CalendarScreen(),
    planner: (context) => const PlannerScreen(),
    hrm: (context) => const HRMScreen(),
    reports: (context) => const ReportsScreen(),
    profile: (context) => const ProfileScreen(),
  };
}
