import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/rlMoel.dart';

class LaterNewsnotifier extends StateNotifier<List<Later>> {
  LaterNewsnotifier() : super([]);

  void add(String name, String title, String url, String description) {
    final laternews = Later(name, title, url, description);
    state = [laternews, ...state];
  }
}

final newsprovider = StateNotifierProvider<LaterNewsnotifier, List<Later>>(
    (ref) => LaterNewsnotifier());
