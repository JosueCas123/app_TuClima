

import 'package:app_tuclima/presentation/widgets/clima/custom_appbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  final name = 'HomeScreen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {

  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}