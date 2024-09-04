import 'package:get/get.dart';
import 'package:lesto/app/data/Models/LoginModel.dart';
import 'package:lesto/app/data/Models/RegisterModel.dart';
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
}
