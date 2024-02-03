import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:minimal_flutter_template/router/route_definition.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  SvgPicture.asset("logo.svg", width: 80),
                  const SizedBox(height: 12.0),
                  Text(
                    'Minimal Flutter Template',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60.0),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                      labelText: 'ユーザー名', border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(height: 12.0),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      labelText: 'パスワード', border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(height: 42.0),
              ConstrainedBox(
                constraints: const BoxConstraints(
                    maxWidth: 400, minWidth: 200, minHeight: 40),
                child: FilledButton(
                    onPressed: () async {
                      SmartDialog.showLoading(msg: 'ログイン中');
                      // ローディング中に見せるために1秒待つ
                      await Future.delayed(const Duration(seconds: 1));

                      await _login().then((value) {
                        context.goNamed(AppRoutes.dashboard.name);
                        SmartDialog.dismiss();
                        SmartDialog.showNotify(
                          msg: 'ログインしました',
                          notifyType: NotifyType.success,
                        );
                      }).catchError((onError) {
                        SmartDialog.dismiss();
                        SmartDialog.showNotify(
                          msg: 'ログインに失敗しました',
                          notifyType: NotifyType.error,
                        );
                      });
                    },
                    child: Text('ログイン',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary))),
              )
            ],
          ),
        ),
      ),
    );
  }

  // TODO: ログイン処理実装
  Future<bool> _login() async {
    /*
    final response = await getIt.get<ApiClient>().post('/login', {
      'username': _usernameController.text,
      'password': _passwordController.text
    });
    return response.statusCode == 200;
    */
    return true;
  }
}
