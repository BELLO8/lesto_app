import 'package:get/get.dart';
import 'package:lesto/app/data/Models/menu_model.dart';
import 'package:lesto/app/data/constants/ApiUrl/endpoint_constant.dart';

class MenuProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = EndPoint.API_URL;
  }

  // Fonction pour convertir une structure JSON en une liste de Category

  getMenu(int id, String dateDebut, String dateFin) async {
    final response =
        await get('${EndPoint.API_URL}/menu/generer/$id/$dateDebut/$dateFin/2');
    if (response.statusCode == 200) {
      Iterable data = response.body['data'];
      var menu = data.map((e) => Dish.fromJson(e)).toList();
      return menu;
    } else {
      return <Dish>[];
    }
  }
}
