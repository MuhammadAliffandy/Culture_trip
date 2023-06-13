import 'package:http/http.dart' as http;

class WeatherAPI {
  Future<http.Response> fetchData(lat, lon) {
    String baseURL = 'http://api.weatherapi.com/v1/current.json?key=b432d8c9b3bf4fe686221738231005&q=$lat,$lon&aqi=no';
    return http.get(Uri.parse(baseURL));
  }
}
