import 'package:future_architecture/core/service/api_service.dart';

import '../models/product_model.dart';

class ProductRepository {
  final ApiService _apiService = ApiService();

  Future<List<ProductModel>> getProducts() async {
    final productsData = await _apiService.fetchProducts();
    return productsData.map((json) => ProductModel.fromJson(json)).toList();
  }
}
