import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minimal_flutter_template/main.dart';

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
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          //padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                //     Image.asset('packages/shrine_images/diamond.png'),
                const SizedBox(height: 16.0),
                Text(
                  'Minimal Flutter Template',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            const SizedBox(height: 80.0),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 400),
              child: TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                    labelText: 'Username', border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(height: 12.0),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 400),
              child: TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                    labelText: 'Password', border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(height: 24.0),
            OverflowBar(
              spacing: 8,
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColorLight)),
                    onPressed: () => {
                          context.goNamed(AppRoutes.dashboard.name),
                        },
                    child: Text('ログイン'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
