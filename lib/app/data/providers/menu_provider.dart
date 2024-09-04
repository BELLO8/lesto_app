import 'package:get/get.dart';
import 'package:lesto/app/data/Models/menu_model.dart';
import 'package:lesto/app/data/constants/ApiUrl/endpoint_constant.dart';

class MenuProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = EndPoint.API_URL;
  }

  // Fonction pour convertir une structure JSON en une liste de Category

  getMenu(int id) async {
    final response = await get('${EndPoint.API_URL}/menu/generer/$id');
    if (response.statusCode == 200) {
      List<Dish> categories = response.body['data'];
      return categories;
    } else {
      return <Dish>[];
    }
  }
}
