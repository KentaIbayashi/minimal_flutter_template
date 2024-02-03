import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:minimal_flutter_template/providers/side_menu_provider.dart';
import 'package:minimal_flutter_template/pages/main/components/header.dart';
import 'package:minimal_flutter_template/pages/responsive.dart';
import 'package:minimal_flutter_template/pages/main/components/side_menu.dart';

class MainPage extends ConsumerWidget {
  final Widget childWidget;
  final GlobalKey<ScaffoldState> _scaffoldKey; // = GlobalKey<ScaffoldState>();
  final UniqueKey childWidgetKey = UniqueKey(); // ここにキーを追加
  MainPage(
      {required this.childWidget,
      required GlobalKey<ScaffoldState> scaffoldKey,
      super.key})
      : _scaffoldKey = scaffoldKey;
  @override
  Widget build(BuildContext context, ref) {
    print("rebuild");
    ref.listen<bool>(sideMenuProvider, (previous, next) {
      print(next);
      if (_scaffoldKey.currentState == null) return;

      if (next) {
        _scaffoldKey.currentState!.openDrawer();
      } else {
        _scaffoldKey.currentState!.closeDrawer();
      }
    });

    // メイン画面で必要なデータを取得する
    return Scaffold(
      key: _scaffoldKey,
      drawer: const SideMenu(),
      onDrawerChanged: (isOpened) {
        ref.read(sideMenuProvider.notifier).state = isOpened;
      },
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 220, minWidth: 220),
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: const SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: SafeArea(
                  child: Column(
                children: [
                  const Header(),
                  Expanded(
                    // childWidgetにKeyを設定して、再ビルドの最小化
                    child: KeyedSubtree(
                      key: childWidgetKey,
                      child: childWidget,
                    ),
                  ),
                ],
              )), //DashboardScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
