import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lesto/app/data/models/menu_model.dart';
import 'package:lesto/app/data/constants/ApiUrl/endpoint_constant.dart';

class MenuProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = EndPoint.API_URL;
  }

  // Fonction pour convertir une structure JSON en une liste de Category

  Future<List<Dish>> getMenu(
      int id, DateTime dateDebut, DateTime dateFin) async {
    final dateFormat = DateFormat('yyyy-MM-dd');
    final dateDebutFormatted = dateFormat.format(dateDebut);
    final dateFinFormatted = dateFormat.format(dateFin);

    try {
      final response = await get(
          '${EndPoint.API_URL}/menu/generer/$id/$dateDebutFormatted/$dateFinFormatted/2');

      if (response.statusCode == 200) {
        Iterable data = response.body['data'];
        var menu = data.map((e) => Dish.fromJson(e)).toList();
        return menu;
      } else {
        return <Dish>[];
      }
    } catch (e) {
      return <Dish>[];
    }
  }
}
