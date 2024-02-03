import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:minimal_flutter_template/providers/router_provider.dart';
import 'package:minimal_flutter_template/providers/side_menu_provider.dart';
import 'package:minimal_flutter_template/router/route_definition.dart';

class SideMenu extends ConsumerWidget {
  const SideMenu({
    super.key,
  });

  String extractPath(String url) {
    List<String> parts = url.split('/');
    if (parts.length >= 2) {
      return '/${parts[1]}';
    } else {
      return url;
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    final router = ref.watch(routerProvider);
    final currentPath =
        extractPath(router.routerDelegate.currentConfiguration.fullPath);
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 20),
            child: SvgPicture.asset("logo.svg", width: 80),
          ),
          const Divider(),
          DrawerListTile(
            isActive: currentPath == AppRoutes.dashboard.path,
            title: "ダッシュボード",
            iconData: Icons.dashboard,
            press: () {
              ref.read(sideMenuProvider.notifier).state = false;
              context.goNamed(AppRoutes.dashboard.name);
            },
          ),
          DrawerListTile(
            isActive: currentPath == AppRoutes.screenOne.path,
            title: "画面1",
            iconData: Icons.account_balance,
            press: () {
              context.goNamed(AppRoutes.screenOne.name);
              ref.read(sideMenuProvider.notifier).state = false;
            },
          ),
          DrawerListTile(
            isActive: currentPath == AppRoutes.screenTwo.path,
            title: "画面2",
            iconData: Icons.category,
            press: () {
              context.goNamed(AppRoutes.screenTwo.name);
              ref.read(sideMenuProvider.notifier).state = false;
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    required this.title,
    required this.press,
    required this.iconData,
    this.isActive = false,
  });

  final String title;
  final VoidCallback press;
  final bool isActive;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListTile(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        selected: isActive,
        selectedTileColor: Theme.of(context).highlightColor,
        onTap: press,
        leading: Icon(iconData),
        title: Text(
          title,
        ),
      ),
    );
  }
}
