import 'dart:developer';

import 'package:api_app/models/product.dart';
import 'package:dio/dio.dart';

class ApiServices {
  final Dio dio = Dio(BaseOptions(baseUrl: "https://dummyjson.com"));

  /// Fetch all the products
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

  /// Add a product using POST
  Future<Product> addProduct(Product product) async {
    Response<dynamic> response = await dio.post(
      '/products/add',
      data: {
        'title': product.title,
        'price': product.price,
        'description': product.description,
        'images': product.images,
        'id': product.id,
        'userId': 1,
      },
    );

    // log('Response: ${response.data}');

    // return response.data;

    Product prd = Product.fromJson(response.data);

    // log('Returned product: ${prd.id}');

    return prd;

    // return Product.fromJson(response.data);
  }

  /// Update the product name - PATCH
  Future<Product> updateProductName(String title, int id) async {
    final response = await dio.patch('/products/$id', data: {'title': title});

    // log('Updated product data: ${response.data}');

    return Product.fromJson(response.data);
  }

  /// Update the whole product - PUT
  Future<Product> updateProduct(Product updatedProduct, int id) async {
    final response = await dio.put(
      '/products/$id',
      data: {'title': updatedProduct.title, 'price': updatedProduct.price},
    );

    // log('Updated: ${response.data}');

    return Product.fromJson(response.data);
  }

  /// Delete a product - DELETE
  Future<bool> deleteProduct(int id) async {
    final response = await dio.delete('/products/$id');

    log('Delete response: ${response.data}');

    if(response.data['isDeleted']){
      return true;
    }
    return false;
  }
}
