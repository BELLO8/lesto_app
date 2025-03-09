import 'package:get/get.dart';
import 'package:lesto/app/data/Models/LoginModel.dart';
import 'package:lesto/app/data/Models/RegisterModel.dart';
import 'package:lesto/app/data/Models/country_model.dart';
import 'package:lesto/app/data/constants/ApiUrl/endpoint_constant.dart';

class AuthProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = EndPoint.API_URL;
  }

  login(LoginModel loginRequest) async {
    final response =
        await post('${EndPoint.API_URL}/login', loginRequest.toJson());
    return response.body;
  }

  register(RegisterModel registerRequest) async {
    final response = await post(
        EndPoint.API_URL + EndPoint.Register_URL, registerRequest.toJson());
    print(response.body);
    return response.body;
  }

  getAllCountry() async {
    final response = await get(EndPoint.API_COUNTRY);
    if (response.statusCode == 200) {
      Iterable data = response.body;
      var countries = data.map((e) => Country.fromJson(e)).toList();
      return countries;
    } else {
      return <Country>[];
    }
  }
}
