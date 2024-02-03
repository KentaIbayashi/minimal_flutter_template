import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:minimal_flutter_template/providers/side_menu_provider.dart';
import 'package:minimal_flutter_template/providers/theme_provider.dart';
import 'package:minimal_flutter_template/pages/responsive.dart';
import 'package:minimal_flutter_template/router/route_definition.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                      ? const Icon(Icons.dark_mode)
                      : const Icon(Icons.light_mode),
                  tooltip: "モード",
                  onPressed: () {
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
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'Logout',
                    child: const Text('ログアウト'),
                    onTap: () {
                      SmartDialog.show(
                        builder: (_) => Container(
                          width: 300,
                          height: 200,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.tertiaryContainer,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "ログアウトしますか？",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onTertiaryContainer,
                                ),
                              ),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      SmartDialog.dismiss();
                                    },
                                    child: Text(
                                      "キャンセル",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 30),
                                  FilledButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Theme.of(context)
                                                  .colorScheme
                                                  .tertiary),
                                    ),
                                    onPressed: () async {
                                      SmartDialog.showLoading(msg: 'ログアウト中');
                                      // ローディング中に見せるために1秒待つ
                                      await Future.delayed(
                                          const Duration(seconds: 1));

                                      await _logout().then((value) {
                                        context.goNamed(AppRoutes.login.name);
                                        SmartDialog.dismiss();
                                        SmartDialog.showNotify(
                                          msg: 'ログアウトしました',
                                          notifyType: NotifyType.success,
                                        );
                                      }).catchError((onError) {
                                        SmartDialog.dismiss();
                                        SmartDialog.showNotify(
                                          msg: 'ログアウトに失敗しました',
                                          notifyType: NotifyType.error,
                                        );
                                      });
                                    },
                                    child: Text(
                                      "ログアウト",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onTertiary,
                                      ),
                                    ),
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
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                      width: 1,
                    ),
                  ),
                  child: ClipOval(
                    child: Image.asset("avatar.png"),
                  ),
                ),
              )
            ],
          )),
    );
  }

  // TODO: ログアウト処理実装
  Future<bool> _logout() async {
    /*
    final response = await getIt.get<ApiClient>().post('/logout', {
    });
    return response.statusCode == 200;
    */
    return true;
  }
}
