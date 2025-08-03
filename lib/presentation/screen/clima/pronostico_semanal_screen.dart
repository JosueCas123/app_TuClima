import 'package:app_tuclima/config/helpers/fomart_time.dart';
import 'package:app_tuclima/presentation/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PronosticoSemanalScreen extends ConsumerWidget {
  Map<String, dynamic> currentValue = {};
  final String city;
  List<dynamic> pastWeek;
  List<dynamic> next7days;

  PronosticoSemanalScreen({
    super.key,
    required this.currentValue,
    required this.city,
    required this.pastWeek,
    required this.next7days,
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('PronosticoSemanalScreen initialized with city: $pastWeek');
    final themeMode = ref.watch(ThemeNotiferProvider);
    final notifier = ref.read(ThemeNotiferProvider.notifier);
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pronóstico Semanal',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData( // Color de la flecha de retroceso
          color: Theme.of(context).colorScheme.secondary,
        ),
        actions: [
          GestureDetector(
            onTap: notifier.toggleTheme,
            child: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: Theme.of(context).colorScheme.secondary, // Color del tema
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      city,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    Text(
                      '${currentValue['temp_c']}°C',
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    Text(
                      currentValue['condition']?['text'] ?? 'Desconocido',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    Image.network(
                      'https:${currentValue['condition']?['icon'] ?? ''}',
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Pronostico de los siguientes 7 días',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              SizedBox(height: 10),
              ...next7days.map((day) {
                final date = day['date'] ?? '';
                final condition =
                    day['day']?['condition']?['text'] ?? 'Sin datos';
                final icon = day['day']?['condition']?['icon'] ?? '';
                final maxTemp = day['day']?['maxtemp_c'] ?? 'N/A';
                final minTemp = day['day']?['mintemp_c'] ?? 'N/A';

                return ListTile(
                  leading: Image.network('https:$icon', width: 40),
                  title: Text(
                    TimeFormatter.formatDate(date),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  subtitle: Text(
                    '$condition $minTemp°C - $maxTemp°C',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                );
              }),
              Text(
                'Pronóstico de la semana pasada',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              SizedBox(height: 10),
              ...pastWeek.map((day) {
                final forescastDate = day['forecast']?['forecastday'] ;
                if(forescastDate == null || forescastDate.isEmpty) {
                  return SizedBox.shrink();
                }
                final forescatDay = forescastDate[0];
                final date = forescatDay['date'] ?? '';
                final condition =
                    forescatDay['day']?['condition']?['text'] ?? 'Sin datos';
                final icon = forescatDay['day']?['condition']?['icon'] ?? '';
                final maxTemp = forescatDay['day']?['maxtemp_c'] ?? 'N/A';
                final minTemp = forescatDay['day']?['mintemp_c'] ?? 'N/A';

                return ListTile(
                  leading: Image.network('https:$icon', width: 40),
                  title: Text(
                    TimeFormatter.formatDate(date),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  subtitle: Text(
                    '$condition $minTemp°C - $maxTemp°C',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}