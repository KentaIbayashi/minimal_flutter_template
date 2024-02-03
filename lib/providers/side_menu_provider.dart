import 'package:flutter_riverpod/flutter_riverpod.dart';

final sideMenuProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});
