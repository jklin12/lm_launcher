import 'package:dio/dio.dart';

class HomeService {
  Future<Response> getData(String tvId) async {
    try {
      var response = await Dio().post(
          'http://localhost/lm_launcher/index.php/api/home',
          data: {'tv_id': tvId});
      return response;
    } on DioError catch (e) {
      throw e;
    }
  }
}
