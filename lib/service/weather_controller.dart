import 'package:get/get.dart';
import 'package:lm_launcher/model/weather_model.dart';
import 'package:lm_launcher/service/weather_service.dart';

class WeatherController extends GetxController {
  final weatherService = Get.put(WeatherService());

  Future<WeatherModel> getWeatherData() async {
    var res;
    try {
      res = await weatherService.getWeather();
      if (res.statusCode != 200 || res.statusCode != 201) {
        return res.data['message'];
      }
    } catch (e) {
      //print(e);
    }
    return WeatherModel.fromJson(res.data);
  }
}
