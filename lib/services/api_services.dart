import 'dart:developer';

import 'package:api_app/models/product.dart';
import 'package:dio/dio.dart';

class ApiServices {
  final Dio dio = Dio(BaseOptions(baseUrl: "https://dummyjson.com"));

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await dio.get('/products');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['products'];

        // log('List: $prd');
        List<Product> products = data.map((e) => Product.fromJson(e)).toList();

        // log('$products');
        return products;
        // log('Products: ${data}');
      }
    } on DioException catch (e) {
      log('Error: ${e.response?.statusCode} - ${e.message}');
    }
    return [];
  }
}
