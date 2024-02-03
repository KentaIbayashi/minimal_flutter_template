import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:minimal_flutter_template/logger.dart';
import 'package:minimal_flutter_template/pages/dashboard/dashboard_page.dart';
import 'package:minimal_flutter_template/pages/login/login_page.dart';
import 'package:minimal_flutter_template/pages/main/main_page.dart';
import 'package:minimal_flutter_template/router/route_definition.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: GlobalKey<NavigatorState>(),
    debugLogDiagnostics: true,
    initialLocation: AppRoutes.login.path,
    observers: [FlutterSmartDialog.observer],
    routes: [
      ShellRoute(
        pageBuilder: (context, state, child) => NoTransitionPage<void>(
          key: state.pageKey,
          child: MainPage(
            childWidget: child,
            scaffoldKey: GlobalKey<ScaffoldState>(),
          ),
        ),
        routes: [
          GoRoute(
            name: AppRoutes.dashboard.name,
            path: AppRoutes.dashboard.path,
            pageBuilder: (context, state) => NoTransitionPage<void>(
              key: state.pageKey,
              child: const DashboardPage(),
            ),
          ),
          GoRoute(
            name: AppRoutes.screenOne.name,
            path: AppRoutes.screenOne.path,
            pageBuilder: (context, state) => NoTransitionPage<void>(
              key: state.pageKey,
              child: const Text("Screen One"),
            ),
          ),
          GoRoute(
            name: AppRoutes.screenTwo.name,
            path: AppRoutes.screenTwo.path,
            pageBuilder: (context, state) => NoTransitionPage<void>(
              key: state.pageKey,
              child: const Text("Screen Two"),
            ),
          ),
        ],
      ),
      GoRoute(
        name: AppRoutes.login.name,
        redirect: (context, state) {
          // ログイン画面に遷移させたくない場合は、条件分岐で他画面のpathを返す
          //if (isAuth) {
          // If the user is authenticated, redirect to the dashboard
          //  return AppRoutes.dashboard.path;
          // }
          return state.path;
        },
        path: AppRoutes.login.path,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: LoginPage(),
        ),
      ),
    ],
    errorPageBuilder: (context, state) => NoTransitionPage<void>(
      key: state.pageKey,
      child: const Text('404 Page not found'),
    ),
    redirect: (context, state) {
      logger.d("path:${state.path}");
      // 未認証の場合は、ログイン画面に遷移させるなどの処理を行う
      //if (!isAuth) {
      // If the user is not authenticated, redirect to the login page
      //  return AppRoutes.login.path; //'/login';
      // }
      return null;
    },
  );
});
