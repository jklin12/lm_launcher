import 'package:dio/dio.dart';
import 'package:lm_launcher/service/base_service.dart';

class WeatherService {
  BaseService service = BaseService();
  static const String apiKey = "f2d304ff4e0283b7ac6eb72809107e82";

  Future<Response> getWeather() async {
    try {
      Response response = await service.request(
          "https://api.openweathermap.org/data/2.5/weather?lat=1.082828&lon=104.030457&appid=$apiKey&units=metric",
          method: "Get");
      //print("https://api.openweathermap.org/data/2.5/weather?lat=1.1426613&lon=104.0184042&appid=$apiKey&units=metric");
      return response;
    } on DioError catch (e) {
      throw handleError(e);
    }
  }
}
