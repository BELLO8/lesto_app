import 'package:get/get.dart';
import 'package:lesto/app/data/models/ingredient_model.dart';
import 'package:lesto/app/data/models/plat_model.dart';

import '../constants/ApiUrl/endpoint_constant.dart';

class PlatProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = EndPoint.API_URL;
  }

  Future<List<Plat>> getPlats() async {
    final response = await get('${EndPoint.API_URL}/plat/show');
    if (response.statusCode == 200) {
      Iterable data = response.body['data'];
      var plats = data.map((e) => Plat.fromJson(e)).toList();
      return plats;
    } else {
      return <Plat>[];
    }
  }

  Future<List<Ingredient>> getPlatsIngredients(id) async {
    final response =
        await get('${EndPoint.API_URL}/ingredient/listIngredientPlat/$id');
    if (response.statusCode == 200) {
      Iterable data = response.body['data'];
      var ingredient = data.map((e) => Ingredient.fromJson(e)).toList();
      return ingredient;
    } else {
      return <Ingredient>[];
    }
  }

  Future<List<Ingredient>> getAllIngredients() async {
    final response = await get('${EndPoint.API_URL}/ingredient/all');
    if (response.statusCode == 200) {
      Iterable data = response.body['data'];
      var ingredient = data.map((e) => Ingredient.fromJson(e)).toList();
      return ingredient;
    } else {
      return <Ingredient>[];
    }
  }

  Future<List<Plat>> searchPlats(search) async {
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
