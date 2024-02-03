import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:minimal_flutter_template/di_container.dart';
import 'package:minimal_flutter_template/main.dart';
import 'package:minimal_flutter_template/providers/side_menu_provider.dart';
import 'package:minimal_flutter_template/providers/theme_provider.dart';
import 'package:minimal_flutter_template/pages/responsive.dart';
import 'package:minimal_flutter_template/services/storage_service.dart';

import '../../../../../constants.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final darkTheme = ref.watch(themeProvider);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // メニューボタン（モバイルの場合のみ表示）
              if (!Responsive.isDesktop(context))
                Consumer(builder: (context, ref, _) {
                  return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      ref.read(sideMenuProvider.notifier).state = true;
                    },
                  );
                }),

              // メニューボタンと検索バーの間にスペースを追加し、右寄せを実現
              const Spacer(),

              // 検索バー
              if (!Responsive.isMobile(context))
                const SizedBox(
                  width: 300,
                  height: 34,
                  child: SearchBar(
                    leading: Padding(
                      padding: EdgeInsets.only(left: 6.0),
                      child: Icon(
                        Icons.search,
                        size: 18,
                      ),
                    ),
                  ),
                ),

              // アイコンボタン（通知、ヘルプ、設定）
              const SizedBox(width: 6),
              IconButton(
                icon: const Icon(Icons.notifications),
                tooltip: "通知",
                onPressed: () {
                  // 通知の処理
                },
              ),
              const SizedBox(width: 6),
              Consumer(builder: (context, ref, _) {
                final darkTheme = ref.watch(themeNotifierProvider);
                return IconButton(
                  icon: darkTheme
                      ? Icon(Icons.dark_mode)
                      : Icon(Icons.light_mode),
                  tooltip: "モード",
                  onPressed: () {
                    // ヘルプの処理
                    // getIt.get<StorageService>().saveIsDarkMode(
                    //     !ref.read(themeProvider.notifier).state);
                    ref.read(themeNotifierProvider.notifier).toggle();
                  },
                );
              }),

              const SizedBox(width: 6),
              IconButton(
                icon: const Icon(Icons.settings),
                tooltip: "設定",
                onPressed: () {
                  // 設定の処理
                },
              ),
              const SizedBox(width: 6),

              // アバター
              PopupMenuButton<String>(
                tooltip: "アカウント",
                onSelected: (String result) {
                  // メニュー項目が選択されたときの処理
                  print(result);
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'Logout',
                    child: Text('ログアウト'),
                    onTap: () {
                      SmartDialog.show(
                        builder: (_) => Container(
                          width: 300,
                          height: 200,
                          color: Theme.of(context).colorScheme.surface,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("ログアウトしますか？"),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      SmartDialog.dismiss();
                                    },
                                    child: const Text("キャンセル"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      GoRouter.of(context)
                                          .goNamed(AppRoutes.login.name);
                                      SmartDialog.dismiss();
                                    },
                                    child: const Text("ログアウト"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
                child: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://creazilla-store.fra1.digitaloceanspaces.com/icons/3409851/square-animal-outlined-face-8-04-panda-icon-md.png'), // 任意のアバター画像
                  radius: 16, // アバターのサイズ
                ),
              )
            ],
          )),
    );
  }
}

class MyCircleAvatar extends StatelessWidget {
  const MyCircleAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: "アカウント",
      onSelected: (String result) {
        // メニュー項目が選択されたときの処理
        print(result);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'Profile',
          child: Text('プロフィールを見る'),
        ),
        const PopupMenuItem<String>(
          value: 'Settings',
          child: Text('設定'),
        ),
        PopupMenuItem<String>(
          value: 'Logout',
          child: Text('ログアウト'),
          onTap: () {
            SmartDialog.show(
              builder: (context) => Container(
                width: 300,
                height: 200,
                color: Theme.of(context).colorScheme.surface,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("ログアウトしますか？"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            SmartDialog.dismiss();
                          },
                          child: const Text("キャンセル"),
                        ),
                        TextButton(
                          onPressed: () {
                            SmartDialog.dismiss();
                            context.goNamed(AppRoutes.login.name);
                          },
                          child: const Text("ログアウト"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
      child: const CircleAvatar(
        backgroundImage: NetworkImage(
            'https://creazilla-store.fra1.digitaloceanspaces.com/icons/3409851/square-animal-outlined-face-8-04-panda-icon-md.png'), // 任意のアバター画像
        radius: 16, // アバターのサイズ
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: defaultPadding),
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/profile_pic.png",
            height: 38,
          ),
          if (!Responsive.isMobile(context))
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Text("Angelina Jolie"),
            ),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(defaultPadding * 0.75),
            margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}
