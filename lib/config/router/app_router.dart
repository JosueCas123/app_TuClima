


import 'package:app_tuclima/presentation/screen/clima/home_screen.dart';
import 'package:app_tuclima/presentation/screen/clima/pronostico_semanal_screen.dart';
import 'package:app_tuclima/presentation/screen/clima/splash_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/clima',
      name: 'clima',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/clima/pronostico_semanal',
      name: 'pronostico_semanal',
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>;
        return PronosticoSemanalScreen(
          currentValue: args['currentValue'],
          city: args['city'],
          pastWeek: args['pastWeek'],
          next7days: args['next7days'],
        );
      },
    ),
  ],
);