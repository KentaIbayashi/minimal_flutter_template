import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      theme: ThemeDefinition.lightTheme,
      darkTheme: ThemeDefinition.darkTheme,
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
              return const SplashScreen();
            }
          },
        );
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset("assets/logo.svg", width: 120),
            const SizedBox(height: 20),
            const CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}

class ThemedContainer extends ConsumerWidget {
  final Widget? child;
  const ThemedContainer({required this.child, super.key});

  @override
  Widget build(BuildContext context, ref) {
    final isDarkMode = ref.watch(themeNotifierProvider);

    return Theme(
      data: isDarkMode ? ThemeDefinition.darkTheme : ThemeDefinition.lightTheme,
      child: child ?? Container(),
    );
  }
}
