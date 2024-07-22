import 'package:get/get.dart';
import 'package:lesto/app/data/Models/menu_model.dart';
import 'package:lesto/app/data/constants/ApiUrl/endpoint_constant.dart';

class MenuProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = EndPoint.API_URL;
  }

  getMenu(int id) async {
    final response = await get('${EndPoint.API_URL}/menu/generer/$id');
    if (response.statusCode == 200) {
      Iterable data = response.body['data'];
      var menu = data.map((e) => Menu.fromJson(e)).toList();
      return menu;
    } else {
      return null;
    }
  }

  Future<Response<Menu>> postMenu(Menu menu) async => await post('menu', menu);
  Future<Response> deleteMenu(int id) async => await delete('menu/$id');
}
