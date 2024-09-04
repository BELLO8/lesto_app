import 'package:get/get.dart';
import 'package:lesto/app/data/Models/plat_model.dart';

import '../constants/ApiUrl/endpoint_constant.dart';

class PlatProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = EndPoint.API_URL;
  }

  getPlats() async {
    final response = await get('${EndPoint.API_URL}/plat/show');
    if (response.statusCode == 200) {
      Iterable data = response.body['data'];
      var plats = data.map((e) => Plat.fromJson(e)).toList();
      return plats;
    } else {
      return <Plat>[];
    }
  }

  searchPlats(search) async {
    final response =
        await post('${EndPoint.API_URL}/plat/search', {"name": search});
    if (response.statusCode == 200) {
      Iterable data = response.body['data'];
      var plats = data.map((e) => Plat.fromJson(e)).toList();
      return plats;
    } else {
      return <Plat>[];
    }
  }
}
