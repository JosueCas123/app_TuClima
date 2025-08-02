


import 'package:app_tuclima/infrastructure/datasource/clima_datasource.dart';
import 'package:app_tuclima/infrastructure/repository/clima_repository.imp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final climaRepositoryProvider = Provider((ref) {
  return ClimaRepositoryImpl(ClimaDatasource());
});