import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:minimal_flutter_template/providers/theme_provider.dart';
import 'package:minimal_flutter_template/theme_definition.dart';
import 'di_container.dart' as di;
import 'providers/router_provider.dart';

void main() async {
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Minimal Flutter Template',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      builder: (context, routedChild) {
        return FutureBuilder(
            future: di.setupLocator(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return FlutterSmartDialog.init()(
                    context, ThemedContainer(child: routedChild));
              } else {
                return Container(
                  color: Theme.of(context).primaryColor,
                  child: const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.ac_unit, size: 200),
                        CircularProgressIndicator()
                      ],
                    ),
                  ),
                );
              }
            });
      },
    );
  }
}

class ThemedContainer extends ConsumerWidget {
  final Widget? child;
  const ThemedContainer({required this.child, super.key});

  @override
  Widget build(BuildContext context, ref) {
    //ref.read(themeProvider)

    final isDarkMode = ref.watch(themeNotifierProvider);

    return Theme(
      data: isDarkMode ? ThemeDefinition.darkTheme : ThemeDefinition.lightTheme,
      child: child ?? Container(),
    );
  }
}

class AppRoutes {
  static const RouteDef dashboard = RouteDef('/dashboard', 'Dashboard');
  static const RouteDef screenOne = RouteDef('/screen_one', 'Screen One');
  static const RouteDef screenTwo = RouteDef('/screen_two', 'Screen Two');
  static const RouteDef login = RouteDef('/login', 'Login');
}

class RouteDef {
  final String path;
  final String name;

  const RouteDef(this.path, this.name);
}
