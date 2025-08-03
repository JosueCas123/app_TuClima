




abstract class ClimasDatasource {
 Future<Map<String, dynamic>> getForecast(String city);
  Future<List<Map<String, dynamic>>> getPastSevenDaysForecast(String city);

}