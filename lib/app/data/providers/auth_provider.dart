import 'package:get/get.dart';
import 'package:lesto/app/data/models/login_model.dart';
import 'package:lesto/app/data/models/register_model.dart';
import 'package:lesto/app/data/models/country_model.dart';
import 'package:lesto/app/data/constants/ApiUrl/endpoint_constant.dart';

class AuthProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = EndPoint.API_URL;
  }

  Future<Map<String, dynamic>?> login(LoginModel loginRequest) async {
    try {
      final response =
          await post('${EndPoint.API_URL}/login', loginRequest.toJson());
      if (response.status.hasError) {
        return {
          'error': true,
          'message': response.statusText ?? 'Erreur lors de la connexion'
        };
      }
      return response.body as Map<String, dynamic>?;
    } catch (e) {
      return {
        'error': true,
        'message': 'Une erreur inattendue est survenue: $e'
      };
    }
  }

  Future<Map<String, dynamic>?> register(RegisterModel registerRequest) async {
    try {
      final response = await post(
          EndPoint.API_URL + EndPoint.Register_URL, registerRequest.toJson());
      if (response.status.hasError) {
        return {
          'error': true,
          'message': response.statusText ?? 'Erreur lors de l\'inscription'
        };
      }
      return response.body as Map<String, dynamic>?;
    } catch (e) {
      return {
        'error': true,
        'message': 'Une erreur inattendue est survenue: $e'
      };
    }
  }

  Future<List<Country>> getAllCountry() async {
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
