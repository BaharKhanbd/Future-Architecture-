import 'package:dio/dio.dart';
import 'package:future_architecture/config/app_url.dart';
import 'package:future_architecture/config/shared_pref_helper.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<dynamic>> fetchProducts() async {
    final String apiUrl = AppUrl.productUrl;

    try {
      final response = await _dio.get(apiUrl);
      return response.data;
    } catch (e) {
      throw Exception("Failed to load products");
    }
  }

  Future<String> login(String email, String password) async {
    try {
      final String apiUrlTwo = AppUrl.loginUrl;
      Response response = await _dio.post(
        apiUrlTwo,
        options: Options(
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
        ),
        data: {
          "email": email,
          "password": password,
        },
      );
      print("Login Response: ${response.data}");
      String token = response.data["token"];
      await SharedPrefHelper.setToken(token);
      print("Saved Token: $token");
      return token;
    } catch (e) {
      throw Exception("Login Failed");
    }
  }
}
