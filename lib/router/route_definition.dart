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
