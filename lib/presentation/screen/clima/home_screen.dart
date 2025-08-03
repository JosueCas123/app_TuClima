

import 'package:app_tuclima/config/helpers/fomart_time.dart';
import 'package:app_tuclima/infrastructure/repository/clima_repository.imp.dart';
import 'package:app_tuclima/presentation/provider/clima/clima_repository_provider.dart';
import 'package:app_tuclima/presentation/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  final name = 'HomeScreen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _HomeView();
  }
}

class _HomeView extends ConsumerStatefulWidget {
  @override
  ConsumerState<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  late final ClimaRepositoryImpl _weatherApi;
  final TextEditingController _searchController = TextEditingController();

  String city = 'La Paz';
  String country = '';
  Map<String, dynamic> currentValue = {};
  List<dynamic> hourly = [];
  List<dynamic> pastWeek = [];
  List<dynamic> next7days = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _weatherApi = ref.read(climaRepositoryProvider);
    _fetchWeatherData();
    _searchController.text = city;
  }

  Future<void> _fetchWeatherData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final forescast = await _weatherApi.getForecast(city);
      final past = await _weatherApi.getPastSevenDaysForecast(city);

      setState(() {
        currentValue = forescast['current'] ?? {};
        hourly = forescast['forecast']?['forecastday']?[0]?['hour'] ?? [];
        next7days = forescast['forecast']?['forecastday'] ?? [];
        pastWeek = past;
        city = forescast['location']?['name'] ?? city;
        country = forescast['location']?['country'] ?? '';
        isLoading = false;
        _searchController.text = city;
      });
    } catch (e) {
      setState(() {
        currentValue = {};
        hourly = [];
        pastWeek = [];
        next7days = [];
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching weather data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(ThemeNotiferProvider);
    final notifier = ref.read(ThemeNotiferProvider.notifier);
    final isDark = themeMode == ThemeMode.dark;

    String iconPath = currentValue['condition']?['icon'] ?? '';
    String imageUrl = iconPath.isNotEmpty ? 'https:${iconPath}' : '';

    Widget imageWidget = imageUrl.isNotEmpty
        ? Image.network(
            imageUrl,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          )
        : SizedBox();

    return Scaffold(
      resizeToAvoidBottomInset: true, // Permite redimensionar con teclado
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          const SizedBox(width: 10),
          Expanded( // Hace que el campo de búsqueda sea flexible
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                controller: _searchController,
                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                onSubmitted: (value) {
                  if (value.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Por favor, ingresa un nombre de ciudad'),
                      ),
                    );
                    return;
                  }
                  city = value.trim();
                  _fetchWeatherData();
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  labelText: 'Buscar ciudad',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: notifier.toggleTheme,
            child: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: isDark ? Colors.black : Colors.white,
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(), // Oculta el teclado al tocar fuera
        behavior: HitTestBehavior.opaque,
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView( // Permite desplazamiento
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    if (currentValue.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '$city${country.isNotEmpty ? ', $country' : ''}',
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
                          imageWidget,
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Container(
                              height: 100,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context).colorScheme.surface,
                                    offset: const Offset(1, 1),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        'https://cdn-icons-png.flaticon.com/256/4148/4148460.png',
                                        width: 30,
                                        height: 30,
                                      ),
                                      Text(
                                        '${currentValue['humidity']}% ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).colorScheme.secondary,
                                        ),
                                      ),
                                      Text(
                                        'Humedad',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context).colorScheme.secondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        'https://cdn-icons-png.flaticon.com/512/2639/2639169.png',
                                        width: 30,
                                        height: 30,
                                      ),
                                      Text(
                                        '${currentValue['wind_kph']} kph',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).colorScheme.secondary,
                                        ),
                                      ),
                                      Text(
                                        'Viento',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context).colorScheme.secondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        'https://cdn-icons-png.flaticon.com/512/6281/6281340.png',
                                        width: 30,
                                        height: 30,
                                      ),
                                      Text(
                                        hourly.isNotEmpty
                                            ? '${hourly.map((h) => h['temp_c']).reduce((a, b) => a > b ? a : b)}°'
                                            : 'N/A',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).colorScheme.secondary,
                                        ),
                                      ),
                                      Text(
                                        'Máx Temp',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context).colorScheme.secondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                             height: 300,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                               borderRadius: BorderRadius.vertical(
                        top: Radius.circular(40),
                      ),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Pronóstico del Día',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).colorScheme.secondary,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          context.push('/clima/pronostico_semanal',
                                            extra: {
                                              'currentValue': currentValue,
                                              'city': city,
                                              'pastWeek': pastWeek,
                                              'next7days': next7days,
                                            });
                                        },
                                        child: Text(
                                          'Pronóstico Semanal',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context).colorScheme.onPrimary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(color: Theme.of(context).colorScheme.secondary),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 165,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: hourly.length,
                                    itemBuilder: (context, index) {
                                      final hour = hourly[index];
                                      final now = DateTime.now();
                                      DateTime? hourTime;
                                      
                                      try {
                                        hourTime = DateTime.parse(hour['time']);
                                      } catch (e) {
                                        print('Error parsing time: $e');
                                      }
                                      
                                      final isCurrentHour = hourTime != null &&
                                          now.hour == hourTime.hour &&
                                          now.day == hourTime.day;

                                      return Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: isCurrentHour
                                                ? Colors.orangeAccent
                                                : Colors.black38,
                                            borderRadius: BorderRadius.circular(40),
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                isCurrentHour
                                                    ? 'Ahora'
                                                    : TimeFormatter.formatTime(hour['time']),
                                                style: TextStyle(
                                                  color: Theme.of(context).colorScheme.secondary,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Image.network(
                                                'https:${hour['condition']['icon']}',
                                                width: 40,
                                                height: 40,
                                                fit: BoxFit.cover,
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                '${hour['temp_c']}°C',
                                                style: TextStyle(
                                                  color: Theme.of(context).colorScheme.secondary,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
      ),
    );
  }
}