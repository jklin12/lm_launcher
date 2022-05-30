import 'package:get/get.dart';
import 'package:lm_launcher/model/home_model.dart';
import 'package:lm_launcher/service/home_service.dart';

class HomeController extends GetxController {
  final HhmeService = Get.put(HomeService());

  Future<HomeModel> getHomeData(String tvId) async {
    var res;
    res = await HhmeService.getData(tvId);
    if (res.statusCode != 200 || res.statusCode != 201) {
      return res.data['message'];
    }
    return HomeModel.fromJson(res.data);
  }
}
