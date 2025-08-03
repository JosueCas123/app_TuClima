
import 'package:app_tuclima/domain/datasource/clima_datasource.dart';


import 'package:app_tuclima/domain/repository/clima_repository.dart';

class ClimaRepositoryImpl extends ClimasRepository {
  final ClimasDatasource datasource;

  ClimaRepositoryImpl(this.datasource);

  @override
  Future<Map<String, dynamic>> getForecast(String city) async {
    return await datasource.getForecast(city);
  }
  @override
  Future<List<Map<String, dynamic>>> getPastSevenDaysForecast(String city) async {
    return await datasource.getPastSevenDaysForecast(city);
  }

  
}