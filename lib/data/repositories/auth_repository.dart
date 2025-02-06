import 'package:future_architecture/core/service/api_service.dart';

class AuthRepository {
  final ApiService _apiService = ApiService();

  Future<String> loginUser(String email, String password) async {
    return await _apiService.login(email, password);
  }
}
