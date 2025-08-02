


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeNotifer extends StateNotifier <ThemeMode> {
  
  ThemeNotifer() : super(ThemeMode.light);

  @override
  ThemeMode build() => ThemeMode.light;
  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}

final ThemeNotiferProvider = StateNotifierProvider<ThemeNotifer, ThemeMode>(
  (ref) => ThemeNotifer(),
);